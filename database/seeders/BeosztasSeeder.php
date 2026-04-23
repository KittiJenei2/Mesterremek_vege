<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class BeosztasSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        DB::table('beosztasok')->insertOrIgnore([
            [
                'dolgozo_id' => 1,
                'napok_id'   => 1,
                'ido_kezdes' => '09:00:00',
                'ido_vege'   => '17:00:00',
            ],
            [
                'dolgozo_id' => 1,
                'napok_id'   => 3,
                'ido_kezdes' => '09:00:00',
                'ido_vege'   => '17:00:00',
            ],
            [
                'dolgozo_id' => 1,
                'napok_id'   => 5,
                'ido_kezdes' => '09:00:00',
                'ido_vege'   => '17:00:00',
            ],
        ]);
    }
}
