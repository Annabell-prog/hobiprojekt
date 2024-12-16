SELECT COUNT(*) AS total_sold_works
FROM completed_pieces
WHERE completed_date > NOW() - INTERVAL 1 MONTH;




