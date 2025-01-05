START TRANSACTION;

-- 1) Lisame uue kasutaja tabelisse 'users'
INSERT INTO users (username, password_hash, email, created_at, updated_at)
VALUES ('keraamikaFänn', 'salasona123', 'ker@example.com', NOW(), NOW());

-- Salvestame äsja lisatud kasutaja ID muutujasse
SET @new_user_id = LAST_INSERT_ID();

-- 2) Lisame uue kollektsiooni tabelisse 'collections'
INSERT INTO collections (name, created_at, updated_at)
VALUES ('Minu keraamika kollektsioon', NOW(), NOW());

-- Salvestame äsja lisatud kollektsiooni ID muutujasse
SET @new_collection_id = LAST_INSERT_ID();

-- 3) Seome kasutaja ja kollektsiooni tabelis 'user_collections'
INSERT INTO user_collections (user_id, collection_id, created_at, updated_at)
VALUES (@new_user_id, @new_collection_id, NOW(), NOW());

-- Kõik õnnestus, kinnitame muudatused
COMMIT;

START TRANSACTION;

-- 1) Lisame uue kollektsiooni tabelisse 'collections'
INSERT INTO collections (name, created_at, updated_at)
VALUES ('Katkine kollektsioon', NOW(), NOW());

-- Salvestame äsja lisatud kollektsiooni ID muutujasse
SET @broken_collection_id = LAST_INSERT_ID();

-- 2) Püüame meelega lisada 'user_collections' rida kasutajaga, keda ei eksisteeri
-- Näiteks seame user_id=999999, mida meie 'users' tabelis pole
INSERT INTO user_collections (user_id, collection_id, created_at, updated_at)
VALUES (999999, @broken_collection_id, NOW(), NOW());

-- Tekib tõenäoliselt Foreign Key viga, seega transaktsioon katkeb
ROLLBACK;
