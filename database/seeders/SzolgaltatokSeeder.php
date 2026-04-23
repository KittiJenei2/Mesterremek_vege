<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SzolgaltatokSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('szolgaltatok')->insertOrIgnore([
            [
                'dolgozo_id' => 1,
                'lehetosegek_id' => 2,
            ],

            [
                'dolgozo_id' => 2,
                'lehetosegek_id' => 1,
            ],
        ]);
    }
}
