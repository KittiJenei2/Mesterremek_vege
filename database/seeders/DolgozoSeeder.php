<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class DolgozoSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $password = Hash::make('jelszo123');

        DB::table('dolgozo')->insertOrIgnore([
            [

                'nev' => 'Példa Dolgozó',
                'email' => 'pelda@freshszalon.hu',
                'telefon' => '06203334444',
                'jelszo' => $password,
                'bio' => 'Kozmetikus 5 év tapasztalattal',
                'kep' => 'pelda.jpg'
            ],
            [
                'nev' => 'Dolgozó Példa',
                'email' => 'dolgozo@freshszalon.hu',
                'telefon' => '06203335555',
                'jelszo' => $password,
                'bio' => 'Férfi és női fodrász egyben!',
                'kep' => 'dolgozo.jpg'
            ]
        ]);
    }
}
