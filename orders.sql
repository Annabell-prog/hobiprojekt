SELECT
    users.username AS UserName,
    collections.name AS CollectionName,
    completed_pieces.notes AS CompletedPieceName,
    completed_pieces.created_at
FROM
    users
        LEFT JOIN
    user_collections ON users.id = user_collections.user_id
        LEFT JOIN
    collections ON user_collections.collection_id = collections.id
        LEFT JOIN
    completed_pieces ON collections.id = completed_pieces.piece_id
ORDER BY
    users.username ASC;
