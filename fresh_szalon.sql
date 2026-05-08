-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3306
-- Létrehozás ideje: 2026. Ápr 28. 10:54
-- Kiszolgáló verziója: 10.4.32-MariaDB
-- PHP verzió: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Adatbázis: `fresh_szalon`
--

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `beosztasok`
--

CREATE TABLE `beosztasok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dolgozo_id` bigint(20) UNSIGNED NOT NULL,
  `napok_id` bigint(20) UNSIGNED NOT NULL,
  `ido_kezdes` time NOT NULL,
  `ido_vege` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `beosztasok`
--

INSERT INTO `beosztasok` (`id`, `dolgozo_id`, `napok_id`, `ido_kezdes`, `ido_vege`) VALUES
(1, 1, 1, '09:00:00', '17:00:00'),
(2, 1, 3, '09:00:00', '17:00:00'),
(3, 1, 5, '09:00:00', '17:00:00');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `dolgozo`
--

CREATE TABLE `dolgozo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(100) NOT NULL,
  `email` varchar(150) NOT NULL,
  `telefon` varchar(20) DEFAULT NULL,
  `jelszo` varchar(255) NOT NULL,
  `bio` text DEFAULT NULL,
  `kep` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `dolgozo`
--

INSERT INTO `dolgozo` (`id`, `nev`, `email`, `telefon`, `jelszo`, `bio`, `kep`) VALUES
(1, 'Példa Dolgozó', 'pelda@freshszalon.hu', '06203334444', '$2y$12$3z5Kx43ZkA4NkEJvwMv06OrG.Y8ABcxb9BcJvaA3X/NxjVkHzak4m', 'Kozmetikus 5 év tapasztalattal', 'pelda.jpg'),
(2, 'Dolgozó Példa', 'dolgozo@freshszalon.hu', '06203335555', '$2y$12$3z5Kx43ZkA4NkEJvwMv06OrG.Y8ABcxb9BcJvaA3X/NxjVkHzak4m', 'Férfi és női fodrász egyben!', 'dolgozo.jpg');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `felhasznalo`
--

CREATE TABLE `felhasznalo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(30) NOT NULL,
  `email` varchar(40) NOT NULL,
  `telefonszam` varchar(11) DEFAULT NULL,
  `jelszo` varchar(255) NOT NULL,
  `keszitve` datetime NOT NULL DEFAULT current_timestamp(),
  `velemenyt_irhat` tinyint(1) NOT NULL DEFAULT 1,
  `foglalhat` tinyint(1) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `felhasznalo`
--

INSERT INTO `felhasznalo` (`id`, `nev`, `email`, `telefonszam`, `jelszo`, `keszitve`, `velemenyt_irhat`, `foglalhat`) VALUES
(1, 'Példa Felhasználó', 'pelda@pelda.com', '06301234567', '$2y$12$c.iBc/gnrJW7Lyn/LtL3S.b0Mgo.XaPTEAHcq7LuJwEkrOsSbWaVi', '2026-04-28 08:43:39', 1, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `idopontfoglalas`
--

CREATE TABLE `idopontfoglalas` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `felhasznalo_id` bigint(20) UNSIGNED NOT NULL,
  `dolgozo_id` bigint(20) UNSIGNED NOT NULL,
  `szolgaltatasok_id` bigint(20) UNSIGNED NOT NULL,
  `datum` date NOT NULL,
  `ido_kezdes` time NOT NULL,
  `ido_vege` time NOT NULL,
  `statuszok_id` bigint(20) UNSIGNED NOT NULL DEFAULT 1,
  `foglalas_idopontja` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `lehetosegek`
--

CREATE TABLE `lehetosegek` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(30) NOT NULL,
  `leiras` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `lehetosegek`
--

INSERT INTO `lehetosegek` (`id`, `nev`, `leiras`) VALUES
(1, 'Fodrász', 'Hajvágás, festés, styling, férfi-női szalonmunkák.'),
(2, 'Kozmetikus', 'Arckezelések, peeling, hidratálás.'),
(3, 'Masszőr', 'Teljes testmasszázs, relaxációs és sportmasszázs.'),
(4, 'Körmös', 'Manikűr, pedikűr, kézápolás egy helyen.'),
(5, 'Sminkes', 'Esküvő? Szalagavató? Hétköznapok könnyítése? Keresd szakembereinket.'),
(6, 'Barber', 'Kifejezetten férfiak számára: szakáll, bajusz, haj igazítás.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2026_04_16_090617_create_napok_table', 1),
(2, '2026_04_16_090638_create_statuszok_table', 1),
(3, '2026_04_16_090645_create_lehetosegek_table', 1),
(4, '2026_04_16_090651_create_dolgozo_table', 1),
(5, '2026_04_16_090657_create_felhasznalo_table', 1),
(6, '2026_04_16_090704_create_szolgaltatasok_table', 1),
(7, '2026_04_16_090710_create_szolgaltatok_table', 1),
(8, '2026_04_16_090717_create_beosztasok_table', 1),
(9, '2026_04_16_090722_create_szabadsagok_table', 1),
(10, '2026_04_16_090729_create_idopontfoglalas_table', 1),
(11, '2026_04_16_090802_create_velemenyek_table', 1),
(12, '2026_04_16_093116_create_termekek_table', 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `napok`
--

CREATE TABLE `napok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(9) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `napok`
--

INSERT INTO `napok` (`id`, `nev`) VALUES
(1, 'Hétfő'),
(2, 'Kedd'),
(3, 'Szerda'),
(4, 'Csütörtök'),
(5, 'Péntek'),
(6, 'Szombat'),
(7, 'Vasárnap');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `statuszok`
--

CREATE TABLE `statuszok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `statuszok`
--

INSERT INTO `statuszok` (`id`, `nev`) VALUES
(1, 'Függőben'),
(2, 'Elfogadva'),
(3, 'Elutasítva'),
(4, 'Elvégezve');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szabadsagok`
--

CREATE TABLE `szabadsagok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dolgozo_id` bigint(20) UNSIGNED NOT NULL,
  `datum_kezdes` date NOT NULL,
  `datum_vege` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szolgaltatasok`
--

CREATE TABLE `szolgaltatasok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(40) NOT NULL,
  `ar` int(11) NOT NULL,
  `idotartam` int(11) NOT NULL,
  `lehetosegek_id` bigint(20) UNSIGNED NOT NULL,
  `leiras` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `szolgaltatasok`
--

INSERT INTO `szolgaltatasok` (`id`, `nev`, `ar`, `idotartam`, `lehetosegek_id`, `leiras`) VALUES
(1, 'Női hajvágás', 6500, 45, 1, 'Professzionális női hajvágás, szárítással együtt.'),
(2, 'Hajszárítás, igazítás', 6000, 45, 1, 'Haj beszárítása, göndörítése/egyenesítése hajmosás nélkül!'),
(3, 'Férfi hajvágás', 4000, 30, 1, 'Modern férfi hajvágás, szakáll igazítással.'),
(4, 'Szakáll- és bajuszigazítás', 6000, 30, 6, 'Férfiak számára, az arc szépítésére, puhítására.'),
(5, 'Arctisztító kezelés', 9000, 60, 2, 'Mélytisztítás, peeling, gőzölés, pakolás.'),
(6, 'Arcmasszázs', 9000, 35, 2, 'Arcpakolás és arcmasszázs összekötve!'),
(7, 'Tini arckezelés', 9000, 60, 2, 'Kifejezetten tinédzserek számára: pattanáskezelés, hegek enyhítése, arc puhítása.'),
(8, 'Relaxáló masszázs', 12000, 60, 3, 'Teljes testmasszázs relaxációs technikákkal.'),
(9, 'Hátmasszázs', 10000, 45, 3, 'Hátizmok fókuszban!'),
(10, 'Kar- és lábmasszázs', 6000, 30, 3, 'Karok és lábak relaxáló kezelése.'),
(11, 'Manikűr', 7000, 90, 4, 'Sima, egyszerű manikűr minta nélkül, kézmasszázzsal.'),
(12, 'Manikűr', 7000, 90, 4, 'Sima, egyszerű manikűr minta nélkül, kézmasszázzsal.'),
(13, 'Manikűr mintával', 12000, 120, 4, 'Manikűr bármilyen mintával, kézmasszázzsal (Az ár mérettől független).'),
(14, 'Elegáns smink', 8000, 90, 5, 'Esküvő, szalagavató, rendezvény.'),
(15, 'Hétköznapi smink', 4000, 60, 5, 'Sima, egyszerű smink a hétköznapokra.');

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szolgaltatok`
--

CREATE TABLE `szolgaltatok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dolgozo_id` bigint(20) UNSIGNED NOT NULL,
  `lehetosegek_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `szolgaltatok`
--

INSERT INTO `szolgaltatok` (`id`, `dolgozo_id`, `lehetosegek_id`) VALUES
(1, 1, 2),
(2, 2, 1);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `termekek`
--

CREATE TABLE `termekek` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `nev` varchar(100) NOT NULL,
  `leiras` text DEFAULT NULL,
  `ar` int(11) NOT NULL,
  `lehetosegek_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- A tábla adatainak kiíratása `termekek`
--

INSERT INTO `termekek` (`id`, `nev`, `leiras`, `ar`, `lehetosegek_id`) VALUES
(1, 'Prémium Hajlakk', 'Erős tartást biztosító, mégis könnyen kifésülhető hajlakk. Cseresznye illattal.', 4500, 1),
(2, 'Hővédő Spray', 'Megóvja a hajat a hajvasaló és a hajszárító okozta hőkárosodástól.', 4200, 1),
(3, 'Nappali Arckrém', 'Nappali arckrém hyaluronsavval és aloe verával, minden bőrtípusra.', 7990, 2),
(4, 'Micellás Víz', 'Kíméletes, mégis hatékony sminklemosó és arctisztító.', 3500, 2),
(5, 'Szakállolaj', 'Férfias illatú, tápláló szakállolaj a puhább szakállért.', 5500, 6),
(6, 'Bőrápoló Olaj', 'Vitaminokkal dúsított olaj a repedezett körömágybőr ellen.', 2500, 4),
(7, 'Fixáló Púder', 'Hosszantartó sminket biztosító, mattító hatású transzparens púder.', 6200, 5);

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `velemenyek`
--

CREATE TABLE `velemenyek` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `felhasznalo_id` bigint(20) UNSIGNED NOT NULL,
  `idopont_id` bigint(20) UNSIGNED NOT NULL,
  `ertekeles` int(11) NOT NULL,
  `velemeny` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexek a kiírt táblákhoz
--

--
-- A tábla indexei `beosztasok`
--
ALTER TABLE `beosztasok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `beosztasok_dolgozo_id_foreign` (`dolgozo_id`),
  ADD KEY `beosztasok_napok_id_foreign` (`napok_id`);

--
-- A tábla indexei `dolgozo`
--
ALTER TABLE `dolgozo`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `dolgozo_email_unique` (`email`);

--
-- A tábla indexei `felhasznalo`
--
ALTER TABLE `felhasznalo`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `idopontfoglalas`
--
ALTER TABLE `idopontfoglalas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idopontfoglalas_felhasznalo_id_foreign` (`felhasznalo_id`),
  ADD KEY `idopontfoglalas_dolgozo_id_foreign` (`dolgozo_id`),
  ADD KEY `idopontfoglalas_szolgaltatasok_id_foreign` (`szolgaltatasok_id`),
  ADD KEY `idopontfoglalas_statuszok_id_foreign` (`statuszok_id`);

--
-- A tábla indexei `lehetosegek`
--
ALTER TABLE `lehetosegek`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `napok`
--
ALTER TABLE `napok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `statuszok`
--
ALTER TABLE `statuszok`
  ADD PRIMARY KEY (`id`);

--
-- A tábla indexei `szabadsagok`
--
ALTER TABLE `szabadsagok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `szabadsagok_dolgozo_id_foreign` (`dolgozo_id`);

--
-- A tábla indexei `szolgaltatasok`
--
ALTER TABLE `szolgaltatasok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `szolgaltatasok_lehetosegek_id_foreign` (`lehetosegek_id`);

--
-- A tábla indexei `szolgaltatok`
--
ALTER TABLE `szolgaltatok`
  ADD PRIMARY KEY (`id`),
  ADD KEY `szolgaltatok_dolgozo_id_foreign` (`dolgozo_id`),
  ADD KEY `szolgaltatok_lehetosegek_id_foreign` (`lehetosegek_id`);

--
-- A tábla indexei `termekek`
--
ALTER TABLE `termekek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `termekek_lehetosegek_id_foreign` (`lehetosegek_id`);

--
-- A tábla indexei `velemenyek`
--
ALTER TABLE `velemenyek`
  ADD PRIMARY KEY (`id`),
  ADD KEY `velemenyek_felhasznalo_id_foreign` (`felhasznalo_id`),
  ADD KEY `velemenyek_idopont_id_foreign` (`idopont_id`);

--
-- A kiírt táblák AUTO_INCREMENT értéke
--

--
-- AUTO_INCREMENT a táblához `beosztasok`
--
ALTER TABLE `beosztasok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT a táblához `dolgozo`
--
ALTER TABLE `dolgozo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `felhasznalo`
--
ALTER TABLE `felhasznalo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT a táblához `idopontfoglalas`
--
ALTER TABLE `idopontfoglalas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `lehetosegek`
--
ALTER TABLE `lehetosegek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT a táblához `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT a táblához `napok`
--
ALTER TABLE `napok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `statuszok`
--
ALTER TABLE `statuszok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT a táblához `szabadsagok`
--
ALTER TABLE `szabadsagok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `szolgaltatasok`
--
ALTER TABLE `szolgaltatasok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT a táblához `szolgaltatok`
--
ALTER TABLE `szolgaltatok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT a táblához `termekek`
--
ALTER TABLE `termekek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT a táblához `velemenyek`
--
ALTER TABLE `velemenyek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Megkötések a kiírt táblákhoz
--

--
-- Megkötések a táblához `beosztasok`
--
ALTER TABLE `beosztasok`
  ADD CONSTRAINT `beosztasok_dolgozo_id_foreign` FOREIGN KEY (`dolgozo_id`) REFERENCES `dolgozo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `beosztasok_napok_id_foreign` FOREIGN KEY (`napok_id`) REFERENCES `napok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `idopontfoglalas`
--
ALTER TABLE `idopontfoglalas`
  ADD CONSTRAINT `idopontfoglalas_dolgozo_id_foreign` FOREIGN KEY (`dolgozo_id`) REFERENCES `dolgozo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idopontfoglalas_felhasznalo_id_foreign` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idopontfoglalas_statuszok_id_foreign` FOREIGN KEY (`statuszok_id`) REFERENCES `statuszok` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `idopontfoglalas_szolgaltatasok_id_foreign` FOREIGN KEY (`szolgaltatasok_id`) REFERENCES `szolgaltatasok` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `szabadsagok`
--
ALTER TABLE `szabadsagok`
  ADD CONSTRAINT `szabadsagok_dolgozo_id_foreign` FOREIGN KEY (`dolgozo_id`) REFERENCES `dolgozo` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `szolgaltatasok`
--
ALTER TABLE `szolgaltatasok`
  ADD CONSTRAINT `szolgaltatasok_lehetosegek_id_foreign` FOREIGN KEY (`lehetosegek_id`) REFERENCES `lehetosegek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `szolgaltatok`
--
ALTER TABLE `szolgaltatok`
  ADD CONSTRAINT `szolgaltatok_dolgozo_id_foreign` FOREIGN KEY (`dolgozo_id`) REFERENCES `dolgozo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `szolgaltatok_lehetosegek_id_foreign` FOREIGN KEY (`lehetosegek_id`) REFERENCES `lehetosegek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `termekek`
--
ALTER TABLE `termekek`
  ADD CONSTRAINT `termekek_lehetosegek_id_foreign` FOREIGN KEY (`lehetosegek_id`) REFERENCES `lehetosegek` (`id`) ON DELETE CASCADE;

--
-- Megkötések a táblához `velemenyek`
--
ALTER TABLE `velemenyek`
  ADD CONSTRAINT `velemenyek_felhasznalo_id_foreign` FOREIGN KEY (`felhasznalo_id`) REFERENCES `felhasznalo` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `velemenyek_idopont_id_foreign` FOREIGN KEY (`idopont_id`) REFERENCES `idopontfoglalas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
