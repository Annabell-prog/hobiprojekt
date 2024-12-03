-- Lisame 'users' tabelisse unikaalsed indeksid 'username' ja 'email' veergudele,
-- et tagada, et iga kasutajanimi ja e-posti aadress on kordumatud.
ALTER TABLE `users`
    ADD UNIQUE INDEX `unique_username` (`username`),
    ADD UNIQUE INDEX `unique_email` (`email`);