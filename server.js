// server.js
const express = require('express');
const path = require('path');
const mysql = require('mysql2');
const fs = require('fs');

const app = express();
const port = 3000;



// Database connection
const db = mysql.createConnection({
    host: '127.0.0.1',
    port: 3308,
    user: 'root',
    password: '123',
    database: 'mydb'
});

// Test database connection
db.connect((err) => {
    if (err) {
        console.error('Database connection failed:', err);
    } else {
        console.log('Connected to MariaDB database');
    }
});

// Middleware to parse form data
app.use(express.urlencoded({ extended: true }));
app.use(express.json());

// Serve static files from the 'public' directory
app.use(express.static('public'));

// Define routes for your HTML files
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.get('/about', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'aboutme.html'));
});

app.get('/contact', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'contact.html'));
});

app.get('/completedpieces', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'completedpieces.html'));
});

// API endpoint to get all collections
app.get('/api/collections', (req, res) => {
    const query = 'SELECT * FROM collections ORDER BY created_at DESC';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).json({ error: 'Database error' });
        } else {
            res.json(results);
        }
    });
});

// API endpoint to get all pieces with collection info
app.get('/api/pieces-with-collections', (req, res) => {
    const query = `
        SELECT p.*, c.name as collection_name, c.description as collection_description
        FROM pieces p 
        LEFT JOIN collections c ON p.collection_id = c.id 
        ORDER BY p.created_at DESC
    `;
    db.query(query, (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).json({ error: 'Database error' });
        } else {
            res.json(results);
        }
    });
});

// API endpoint to get all pieces
app.get('/api/pieces', (req, res) => {
    const query = `
        SELECT p.*, c.name as collection_name 
        FROM pieces p 
        LEFT JOIN collections c ON p.collection_id = c.id 
        ORDER BY p.created_at DESC
    `;
    db.query(query, (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).json({ error: 'Database error' });
        } else {
            res.json(results);
        }
    });
});

// API endpoint to get pieces by collection
app.get('/api/collections/:id/pieces', (req, res) => {
    const collectionId = req.params.id;
    const query = 'SELECT * FROM pieces WHERE collection_id = ? ORDER BY created_at DESC';
    db.query(query, [collectionId], (err, results) => {
        if (err) {
            console.error('Database query error:', err);
            res.status(500).json({ error: 'Database error' });
        } else {
            res.json(results);
        }
    });
});

// Handle contact form submission
app.post('/contact', (req, res) => {
    let { email, message } = req.body;

    // Tugev e-maili valideerimise funktsioon
    function validateEmail(email) {
        if (!email || typeof email !== 'string') {
            return { valid: false, message: 'Email is required!' };
        }
        
        email = email.trim();
        
        if (email.length === 0) {
            return { valid: false, message: 'Email cannot be empty!' };
        }
        
        if (email.length > 100) {
            return { valid: false, message: 'Email is too long!' };
        }
        
        // Tugev e-maili regex
        const emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
        if (!emailPattern.test(email)) {
            return { valid: false, message: 'Invalid email format!' };
        }
        
        // Keelatud märgid ja mustrid
        const forbiddenPatterns = [
            /<.*?>/g,        // HTML tagid
            /javascript:/i,   // JavaScript URL
            /data:/i,        // Data URL
            /vbscript:/i,    // VBScript
            /on\w+=/i,       // Event handlerid (onclick, onerror jne)
            /[<>'"]/,        // Ohtlikud märgid
            /\x00-\x1f/,     // Kontrollmärgid
            /\x7f-\x9f/      // Kontrollmärgid
        ];
        
        for (let pattern of forbiddenPatterns) {
            if (pattern.test(email)) {
                return { valid: false, message: 'Email contains forbidden characters!' };
            }
        }
        
        return { valid: true, message: 'OK' };
    }
    
    // Sõnumi valideerimise funktsioon
    function validateMessage(message) {
        if (!message || typeof message !== 'string') {
            return { valid: false, message: 'Message is required!' };
        }
        
        message = message.trim();
        
        if (message.length === 0) {
            return { valid: false, message: 'Message cannot be empty!' };
        }
        
        if (message.length > 1000) {
            return { valid: false, message: 'Message is too long (max 1000 characters)!' };
        }
        
        return { valid: true, message: 'OK' };
    }

    // Valideeri sisendid
    const emailValidation = validateEmail(email);
    if (!emailValidation.valid) {
        return res.status(400).json({
            success: false,
            message: emailValidation.message
        });
    }
    
    const messageValidation = validateMessage(message);
    if (!messageValidation.valid) {
        return res.status(400).json({
            success: false,
            message: messageValidation.message
        });
    }

    // Puhasta sisendid (eemaldab HTML tagid ja ohtlikud märgid)
    email = email.trim().replace(/<.*?>/g, '').replace(/[<>'"]/g, '');
    message = message.trim().replace(/<.*?>/g, '').replace(/[<>]/g, '');

    // Logi salvestamine logifaili
    const logEntry = `${new Date().toISOString()} | Email: ${email} | Message: ${message.substring(0, 100)}${message.length > 100 ? '...' : ''}\n`;
    const logPath = path.join(__dirname, 'logs', 'contact.log');
    fs.mkdirSync(path.join(__dirname, 'logs'), { recursive: true });
    fs.appendFileSync(logPath, logEntry);

    // Save to database (create inquiries table if needed)
    const query = `
        INSERT INTO inquiries (email, message, created_at) 
        VALUES (?, ?, NOW())
        ON DUPLICATE KEY UPDATE 
        email = VALUES(email)
    `;
    
    // First ensure the inquiries table exists
    const createTableQuery = `
        CREATE TABLE IF NOT EXISTS inquiries (
            id INT AUTO_INCREMENT PRIMARY KEY,
            email VARCHAR(191) NOT NULL,
            message TEXT NOT NULL,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
            status ENUM('new', 'replied', 'closed') DEFAULT 'new'
        )
    `;
    
    db.query(createTableQuery, (err) => {
        if (err) {
            console.error('Error creating inquiries table:', err);
        }
        
        // Insert the inquiry
        db.query(query, [email, message], (err, result) => {
            if (err) {
                console.error('Database insert error:', err);
                res.status(500).json({
                    success: false,
                    message: 'Sorry, there was an error processing your message.'
                });
            } else {
                console.log('Inquiry saved to database with ID:', result.insertId);
                res.json({
                    success: true,
                    message: 'Thank you! Your message has been sent successfully! We will contact you soon.'
                });
            }
        });
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});

// Restart the server
// process.on('SIGINT', () => {
//    console.log('Shutting down server...');
//  process.exit(0);
// }); 