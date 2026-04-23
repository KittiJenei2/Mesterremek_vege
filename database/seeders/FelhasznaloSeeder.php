<?php

namespace Database\Seeders;

use DateTime;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Nette\Utils\DateTime as UtilsDateTime;

use function Symfony\Component\Clock\now;

class FelhasznaloSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $password = Hash::make('jelszo123');
        
        DB::table('felhasznalo')->insertOrIgnore([
            [

                'nev' => 'Példa Felhasználó',
                'email' => 'pelda@pelda.com',
                'telefon' => '06301234567',
                'jelszo' => $password,
                'keszitve' => now(),
                'velemenyt_irhat' => 1,
                'foglalhat' => 1,
            ],
        ]);
    }
}
