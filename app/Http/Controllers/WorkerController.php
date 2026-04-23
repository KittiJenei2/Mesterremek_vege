<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Log;
use App\Models\Idopontfoglalas;
use App\Models\Szabadsagok;
use App\Mail\FoglalasLemondva;
use Carbon\Carbon;

class WorkerController extends Controller
{
    /**
     * Kijelentkezés a dolgozói fiókból
     */
    public function logout(Request $request)
    {
        Auth::guard('worker')->logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();
        return redirect()->route('login.show');
    }

    // --- FŐ METÓDUSOK ---

    /**
     * Dolgozói műszerfal megjelenítése (Naptár + Táblázat)
     */
    public function dashboard()
    {
        $dolgozo = Auth::guard('worker')->user();

        // 1. Közelgő foglalások a táblázathoz (Lapozással a teljesítményért)
        $foglalasok = Idopontfoglalas::where('dolgozo_id', $dolgozo->id)
            ->with(['felhasznalo', 'szolgaltatas', 'statusz'])
            ->whereDate('datum', '>=', now())
            ->orderBy('datum')
            ->orderBy('ido_kezdes')
            ->paginate(10);

        // 2. Adatok a naptárhoz
        $osszesFoglalas = Idopontfoglalas::where('dolgozo_id', $dolgozo->id)
            ->where('statuszok_id', '!=', 3) // Az elutasítottak ne rontsák a naptárképet
            ->with(['felhasznalo', 'szolgaltatas'])
            ->get();
            
        $szabadsagok = Szabadsagok::where('dolgozo_id', $dolgozo->id)->get();

        // Naptár JSON formázása segédmetódussal
        $calendarEvents = $this->generateCalendarEvents($osszesFoglalas, $szabadsagok);

        return view('worker.dashboard', compact('dolgozo', 'foglalasok', 'calendarEvents'));
    }

    /**
     * Foglalás elfogadása és az ütköző kérések automatikus elutasítása
     */
    public function updateStatus($id)
    {
        $dolgozoId = Auth::guard('worker')->id();

        $foglalas = Idopontfoglalas::where('id', $id)
            ->where('dolgozo_id', $dolgozoId)
            ->firstOrFail();

        $foglalas->statuszok_id = 2; // Elfogadva
        $foglalas->save();

        $utkozoFoglalasok = Idopontfoglalas::where('dolgozo_id', $dolgozoId)
            ->whereDate('datum', $foglalas->datum)
            ->where('statuszok_id', 1)
            ->where('id', '!=', $foglalas->id)
            ->where(function ($query) use ($foglalas) {
                $query->where('ido_kezdes', '<', $foglalas->ido_vege)
                      ->where('ido_vege', '>', $foglalas->ido_kezdes);
            })
            ->with(['felhasznalo', 'szolgaltatas'])
            ->get();

        foreach ($utkozoFoglalasok as $utkozo) {
            $utkozo->statuszok_id = 3; // Elutasítva
            $utkozo->save();

            try {
                Mail::to($utkozo->felhasznalo->email)->queue(
                    new FoglalasLemondva([
                        'nev' => $utkozo->felhasznalo->nev,
                        'szolgaltatas' => $utkozo->szolgaltatas->nev,
                        'datum' => $utkozo->datum,
                        'ido' => substr($utkozo->ido_kezdes, 0, 5),
                        'ok' => 'Sajnáljuk, de az időpont időközben betelt egy másik foglalás miatt.'
                    ])
                );
            } catch (\Exception $e) {
                Log::error('Elutasító email hiba: ' . $e->getMessage());
            }
        }

        return back()->with('success', 'A foglalást elfogadtad, az ütköző kérések pedig automatikusan elutasításra kerültek.');
    }

    /**
     * Foglalás elutasítása a dolgozó által (Külön gombhoz)
     */
    public function rejectStatus($id)
    {
        $dolgozoId = Auth::guard('worker')->id();

        $foglalas = Idopontfoglalas::where('id', $id)
            ->where('dolgozo_id', $dolgozoId)
            ->with(['felhasznalo', 'szolgaltatas'])
            ->firstOrFail();

        $foglalas->statuszok_id = 3; 
        $foglalas->save();

        try {
            Mail::to($foglalas->felhasznalo->email)->queue(
                new FoglalasLemondva([
                    'nev' => $foglalas->felhasznalo->nev,
                    'szolgaltatas' => $foglalas->szolgaltatas->nev,
                    'datum' => $foglalas->datum,
                    'ido' => substr($foglalas->ido_kezdes, 0, 5),
                    'ok' => 'Sajnáljuk, de a kért időpontot jelenleg nem tudjuk vállalni. Kérjük, próbálj meg egy másik időpontot foglalni a weboldalunkon!'
                ])
            );
        } catch (\Exception $e) {
            Log::error('Elutasító email hiba: ' . $e->getMessage());
        }

        return back()->with('success', 'A foglalást elutasítottad, a vendéget e-mailben értesítettük.');
    }

    /**
     * Új szabadság rögzítése (Kétlépcsős mentéssel)
     */
    public function storeVacation(Request $request)
    {
        $this->validateVacation($request);
        $dolgozoId = Auth::guard('worker')->id();

        if ($this->hasVacationOverlap($dolgozoId, $request->datum_kezdes, $request->datum_vege)) {
            return back()->withErrors(['datum_kezdes' => 'A megadott időszak átfedésben van egy már rögzített szabadsággal!'])->withInput();
        }

        $utkozoFoglalasok = $this->getConflictingAppointments($dolgozoId, $request->datum_kezdes, $request->datum_vege);

        if ($utkozoFoglalasok->count() > 0 && !$request->has('force_save')) {
            return back()->with('vacation_conflicts', $utkozoFoglalasok)
                         ->with('pending_vacation', $request->all());
        }

        $szabadsag = Szabadsagok::create([
            'dolgozo_id' => $dolgozoId,
            'datum_kezdes' => $request->datum_kezdes,
            'datum_vege' => $request->datum_vege,
        ]);

        if ($utkozoFoglalasok->count() > 0) {
            $this->rejectAppointmentsDueToVacation($utkozoFoglalasok, $szabadsag);
        }

        return back()->with('success', 'Szabadság sikeresen rögzítve.');
    }

    /**
     * Meglévő szabadság módosítása (Kétlépcsős mentéssel)
     */
    public function updateVacation(Request $request, $id)
    {
        $this->validateVacation($request);
        $dolgozoId = Auth::guard('worker')->id();

        if ($this->hasVacationOverlap($dolgozoId, $request->datum_kezdes, $request->datum_vege, $id)) {
            return back()->withErrors(['datum_kezdes' => 'A módosított időszak átfedésben van egy másik szabadságoddal!'])->withInput();
        }

        $utkozoFoglalasok = $this->getConflictingAppointments($dolgozoId, $request->datum_kezdes, $request->datum_vege);

        if ($utkozoFoglalasok->count() > 0 && !$request->has('force_save')) {
            return back()->with('vacation_conflicts', $utkozoFoglalasok)
                         ->with('pending_vacation', $request->all())
                         ->with('pending_vacation_id', $id);
        }

        $szabadsag = Szabadsagok::where('id', $id)->where('dolgozo_id', $dolgozoId)->firstOrFail();
        $szabadsag->update([
            'datum_kezdes' => $request->datum_kezdes,
            'datum_vege' => $request->datum_vege,
        ]);

        if ($utkozoFoglalasok->count() > 0) {
            $this->rejectAppointmentsDueToVacation($utkozoFoglalasok, $szabadsag);
        }

        return back()->with('success', 'Szabadság sikeresen módosítva.');
    }

    /**
     * Szabadság törlése
     */
    public function destroyVacation($id)
    {
        Szabadsagok::where('id', $id)
            ->where('dolgozo_id', Auth::guard('worker')->id())
            ->firstOrFail()
            ->delete();

        return back()->with('success', 'Szabadság sikeresen törölve.');
    }


    // --- PRIVÁT SEGÉDMETÓDUSOK (CLEAN CODE) ---

    private function validateVacation(Request $request)
    {
        $request->validate([
            'datum_kezdes' => 'required|date|after_or_equal:today',
            'datum_vege' => 'required|date|after_or_equal:datum_kezdes',
        ], [
            'datum_kezdes.after_or_equal' => 'A szabadság kezdete nem lehet a múltban!',
            'datum_vege.after_or_equal' => 'A szabadság vége nem lehet korábban, mint a kezdete!'
        ]);
    }

    private function hasVacationOverlap($dolgozoId, $kezdes, $vege, $ignoreId = null)
    {
        $query = Szabadsagok::where('dolgozo_id', $dolgozoId)
            ->where(function ($q) use ($kezdes, $vege) {
                $q->where('datum_kezdes', '<=', $vege)
                  ->where('datum_vege', '>=', $kezdes);
            });

        if ($ignoreId) {
            $query->where('id', '!=', $ignoreId);
        }

        return $query->exists();
    }

    private function getConflictingAppointments($dolgozoId, $kezdes, $vege)
    {
        return Idopontfoglalas::where('dolgozo_id', $dolgozoId)
            ->whereIn('statuszok_id', [1, 2]) // Csak a Függőben és Elfogadva állapotúakat keressük
            ->whereDate('datum', '>=', $kezdes)
            ->whereDate('datum', '<=', $vege)
            ->with(['felhasznalo', 'szolgaltatas'])
            ->get();
    }

    private function rejectAppointmentsDueToVacation($foglalasok, $szabadsag)
    {
        foreach ($foglalasok as $foglalas) {
            $foglalas->statuszok_id = 3; // Elutasítva
            $foglalas->save();

            try {
                Mail::to($foglalas->felhasznalo->email)->queue(
                    new FoglalasLemondva([
                        'nev' => $foglalas->felhasznalo->nev,
                        'szolgaltatas' => $foglalas->szolgaltatas->nev,
                        'datum' => $foglalas->datum,
                        'ido' => substr($foglalas->ido_kezdes, 0, 5),
                        'ok' => 'A dolgozó szabadsága miatt ('. $szabadsag->datum_kezdes .' - '. $szabadsag->datum_vege .') az időpontod sajnos törlésre került. Kérjük, foglalj egy új időpontot!'
                    ])
                );
            } catch (\Exception $e) {
                Log::error('Szabadság email hiba: ' . $e->getMessage());
            }
        }
    }

    private function generateCalendarEvents($foglalasok, $szabadsagok)
    {
        $events = [];

        foreach ($foglalasok as $f) {
            $color = match ((int)$f->statuszok_id) {
                1 => '#ffc107',
                2 => '#198754',
                4 => '#0d6efd',
                default => '#6c757d'
            };

            $events[] = [
                'title' => $f->felhasznalo->nev . ' (' . $f->szolgaltatas->nev . ')',
                'start' => $f->datum . 'T' . $f->ido_kezdes,
                'end' => $f->datum . 'T' . $f->ido_vege,
                'color' => $color,
            ];
        }

        foreach ($szabadsagok as $sz) {
            $events[] = [
                'title' => '🏖 Szabadság',
                'start' => $sz->datum_kezdes,
                'end' => Carbon::parse($sz->datum_vege)->addDay()->format('Y-m-d'),
                'color' => '#dc3545',
                'display' => 'block'
            ];
        }

        return $events;
    }
}