// server.js
const express = require('express');
const path = require('path');

const app = express();
const port = 3000;

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

// Handle contact form submission
app.post('/contact', (req, res) => {
    const { email, message } = req.body;

    // Log the received data
    console.log('Contact form submission received:');
    console.log('Email:', email);
    console.log('Message:', message);
    console.log('Timestamp:', new Date().toISOString());

    // Send a JSON response indicating success
    res.json({
        success: true,
        message: 'Thank you! Your message has been sent successfully! We will contact you soon.'
    });
});

// Start the server
app.listen(port, () => {
    console.log(`Server is running on http://localhost:${port}`);
});