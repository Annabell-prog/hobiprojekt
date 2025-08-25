CREATE TABLE IF NOT EXISTS inquiries (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(191) NOT NULL,
    message TEXT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    status ENUM('new', 'replied', 'closed') DEFAULT 'new'
);

SELECT COUNT(*) AS total_sold_works
FROM completed_pieces
WHERE completed_date > NOW() - INTERVAL 1 MONTH;




