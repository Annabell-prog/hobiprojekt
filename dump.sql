-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Nov 14, 2024 kell 02:13 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `hobby_project`
--

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `collections`
--

CREATE TABLE `collections` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `completed_pieces`
--

CREATE TABLE `completed_pieces` (
  `id` int(10) UNSIGNED NOT NULL,
  `piece_id` int(10) UNSIGNED NOT NULL,
  `completed_date` date NOT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `pieces`
--

CREATE TABLE `pieces` (
  `id` int(10) UNSIGNED NOT NULL,
  `collection_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `piece_type` varchar(50) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `piece_tags`
--

CREATE TABLE `piece_tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `piece_id` int(10) UNSIGNED NOT NULL,
  `tag_id` int(10) UNSIGNED NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `tags`
--

CREATE TABLE `tags` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `username` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `password_hash` char(60) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `user_collections`
--

CREATE TABLE `user_collections` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `collection_id` int(10) UNSIGNED NOT NULL,
  `role` enum('owner','editor','viewer') NOT NULL DEFAULT 'viewer',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `completed_pieces`
--
ALTER TABLE `completed_pieces`
  ADD PRIMARY KEY (`id`),
  ADD KEY `piece_id` (`piece_id`);

--
-- Indeksid tabelile `pieces`
--
ALTER TABLE `pieces`
  ADD PRIMARY KEY (`id`),
  ADD KEY `collection_id` (`collection_id`);

--
-- Indeksid tabelile `piece_tags`
--
ALTER TABLE `piece_tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `piece_id` (`piece_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indeksid tabelile `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indeksid tabelile `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indeksid tabelile `user_collections`
--
ALTER TABLE `user_collections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `collection_id` (`collection_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `collections`
--
ALTER TABLE `collections`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `completed_pieces`
--
ALTER TABLE `completed_pieces`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `pieces`
--
ALTER TABLE `pieces`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `piece_tags`
--
ALTER TABLE `piece_tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT tabelile `user_collections`
--
ALTER TABLE `user_collections`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `completed_pieces`
--
ALTER TABLE `completed_pieces`
  ADD CONSTRAINT `completed_pieces_ibfk_1` FOREIGN KEY (`piece_id`) REFERENCES `pieces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Piirangud tabelile `pieces`
--
ALTER TABLE `pieces`
  ADD CONSTRAINT `pieces_ibfk_1` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Piirangud tabelile `piece_tags`
--
ALTER TABLE `piece_tags`
  ADD CONSTRAINT `piece_tags_ibfk_1` FOREIGN KEY (`piece_id`) REFERENCES `pieces` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `piece_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Piirangud tabelile `user_collections`
--
ALTER TABLE `user_collections`
  ADD CONSTRAINT `user_collections_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `user_collections_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
