-- Logitabeli loomine muudatuste jälgimiseks `collections` tabelis
CREATE TABLE collections_log (
                                 log_id INT AUTO_INCREMENT PRIMARY KEY,
                                 collection_id INT,
                                 old_name VARCHAR(191),
                                 new_name VARCHAR(191),
                                 changed_by VARCHAR(255),
                                 changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Triger, mis salvestab muudatused pärast `collections` tabeli uuendamist
CREATE TRIGGER after_collections_update
    AFTER UPDATE ON collections
    FOR EACH ROW
BEGIN
    INSERT INTO collections_log (collection_id, old_name, new_name, changed_by, changed_at)
    VALUES (OLD.id, OLD.name, NEW.name, USER(), NOW());
END;

-- Triger, mis kontrollib uue kasutaja e-posti aadressi formaati enne andmete sisestamist
CREATE TRIGGER before_user_insert
    BEFORE INSERT ON users
    FOR EACH ROW
BEGIN
    IF NOT NEW.email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid email format';
    END IF;
END;



