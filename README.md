# LYZELL's POTTERY

This webpage showcases a pottery artist's work with a complete overview of her ceramic creations.

## Features
- **Portfolio Gallery**: Browse through various pottery artworks and collections
- **Artist Information**: Learn about the pottery artist and their craft
- **Completed Pieces**: View finished pottery works with detailed information
- **Contact Information**: Get in touch with the artist for inquiries
- **Responsive Design**: Clean, modern interface optimized for all devices

## Setup
1. Start database: `docker-compose up -d`
2. Start application: `npm start`
3. Access: http://localhost:3000

## Project Structure
```
├── public/                 # Static frontend files
│   ├── index.html         # Main homepage
│   ├── aboutme.html       # About Me page
│   ├── contact.html       # Contact page with form
│   ├── completedpieces.html # Completed works gallery
│   ├── header.html        # Shared header component
│   └── images/            # Pottery images and assets
├── server.js              # Express.js server configuration
├── docker-compose.yml     # Docker services configuration
├── package.json           # Node.js dependencies and scripts
└── README.md              # Project documentation
```

## Technical Stack
- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Node.js with Express.js framework
- **Database**: MySQL/MariaDB with comprehensive pottery management schema
- **Static Assets**: Images and styling served through Express static middleware

## Prerequisites

Before running this application, ensure you have the following installed:

- **Node.js** (version 14 or higher)
- **npm** (Node Package Manager)
- **MySQL Server** or **MariaDB**
- **Docker** (optional, for containerized database setup)

## Installation

1. Install the required Node.js dependencies:
   ```bash
   npm install
   ```

## Database Setup

### Option 1: Local MySQL/MariaDB Setup

1. Ensure your MySQL or MariaDB server is running on your local machine

2. Create and initialize the database using the provided SQL dump:
   ```bash
   mysql -u root -p mydb < dump.sql
   ```

   This command will:
   - Create the `mydb` database
   - Set up all necessary tables (collections, pieces, completed_pieces, tags, users, etc.)
   - Configure proper relationships and constraints between tables

### Option 2: Docker Setup (Recommended)

For a quick setup with Docker, you can use the provided docker-compose configuration:

1. Start the MariaDB container:
   ```bash
   docker-compose up mariadb -d
   ```

2. Wait for the container to be ready, then initialize the database:
   ```bash
   mysql -h 127.0.0.1 -P 3308 -u root -p123 mydb < dump.sql
   ```

### Database Schema Overview

The application uses a comprehensive database schema designed for pottery management:

- **collections**: Pottery collections and series
- **pieces**: Individual pottery items
- **completed_pieces**: Finished works with completion dates
- **tags**: Categorization system for pottery pieces
- **users**: User management system
- **piece_tags**: Many-to-many relationship between pieces and tags
- **user_collections**: User collection associations

## Running the Application

1. Start the Express.js server:
   ```bash
   npm start
   ```

   Or alternatively:
   ```bash
   node server.js
   ```

2. Open your web browser and navigate to:
   ```
   http://localhost:3000
   ```

## Available Routes

The application provides the following routes:

- `/` - Home page with pottery showcase
- `/about` - Artist information and biography
- `/contact` - Contact form and information
- `/completedpieces` - Gallery of completed pottery works

## Development

### Adding New Pottery Pieces

To add new pottery pieces to the database, you can:

1. Insert records into the `collections` table for new series
2. Add individual pieces to the `pieces` table
3. Mark pieces as completed in the `completed_pieces` table
4. Associate pieces with tags using the `piece_tags` table

### Customizing the Frontend

The frontend files are located in the `public/` directory:

- Modify HTML files to change page content and structure
- Update CSS styles for visual customization
- Add new images to the `public/images/` directory

## Troubleshooting

### Common Issues

1. **Database Connection Error**: Ensure your MySQL/MariaDB server is running and accessible
2. **Port Already in Use**: Check if port 3000 is available or modify the port in `server.js`
3. **Missing Dependencies**: Run `npm install` to ensure all packages are installed

### Database Connection

If you encounter database connection issues, verify:
- MySQL/MariaDB service is running
- Database credentials are correct
- The `mydb` database exists
- All tables have been created from the dump file

## License

This project is licensed under the ISC License.
