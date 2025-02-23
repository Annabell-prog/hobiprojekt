# Lyzell's Pottery

This webpage is about a pottery artist. It provides an overview of her works and information about her art. The webpage is built using HTML and served using an Express.js server with MySQL database integration.

## Prerequisites

- Node.js (v14 or higher)
- MySQL Server
- npm (Node Package Manager)

## Installation

1. Install the required dependencies:
   ```sh
   npm install
   ```

## Database Setup

1. Make sure your MySQL server is running
2. Initialize the database by running:
   ```sh
   mysql -u root -p < dump.sql
   ```
   This will create and populate the necessary database tables.

## Running the Application

1. Start the server:
   ```sh
   node server.js
   ```

2. Open your browser and navigate to `http://localhost:3000`

## Features

- Browse pottery artworks
- View artist information
- Place orders for pottery items
- Contact form for inquiries

## Technical Stack

- Frontend: HTML, CSS, JavaScript
- Backend: Express.js
- Database: MySQL
