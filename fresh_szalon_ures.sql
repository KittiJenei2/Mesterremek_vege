-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Gép: 127.0.0.1:3306
-- Létrehozás ideje: 2026. Ápr 28. 11:12
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

-- --------------------------------------------------------

--
-- Tábla szerkezet ehhez a táblához `szolgaltatok`
--

CREATE TABLE `szolgaltatok` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `dolgozo_id` bigint(20) UNSIGNED NOT NULL,
  `lehetosegek_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `dolgozo`
--
ALTER TABLE `dolgozo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `felhasznalo`
--
ALTER TABLE `felhasznalo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `idopontfoglalas`
--
ALTER TABLE `idopontfoglalas`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `lehetosegek`
--
ALTER TABLE `lehetosegek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `szolgaltatok`
--
ALTER TABLE `szolgaltatok`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT a táblához `termekek`
--
ALTER TABLE `termekek`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

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
