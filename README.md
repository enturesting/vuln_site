# OWASP Juice Shop - Local Development Environment

## What is OWASP Juice Shop?

OWASP Juice Shop is an intentionally insecure web application designed for security training, awareness demonstrations, and testing security tools. It's written in Node.js, Express, and Angular and contains over 100 security vulnerabilities covering the entire OWASP Top 10 and beyond.

**Key Features:**
- Modern single-page application (SPA) architecture
- RESTful API backend
- Multiple user authentication methods
- Shopping cart functionality
- Product search and filtering
- File upload capabilities
- Admin panel
- Customer feedback system
- User registration and login
- Password reset functionality

## 🚀 Quick Start

### One-Command Setup

```bash
# Start Juice Shop
./start.sh

# Check if it's running
./health-check.sh
```

**🌐 Main URL**: http://localhost:3000

**👤 Test Credentials**:
- Email: `admin@juice-sh.op`
- Password: `admin123`

### Integration with QA Tools

```bash
# Start Juice Shop
cd juice-shop-local
./start.sh

# Wait for it to be ready
./health-check.sh

# Run your QA tool
cd ../aie-hackathon
source venv/bin/activate
python qa_agent.py http://localhost:3000
```

## Detailed Setup

### Prerequisites
- Docker and Docker Compose installed
- Port 3000 available on localhost

### Start Juice Shop
```bash
# Start the application
docker compose up -d

# Or use the convenience script
./start.sh
```

The application will be available at: **http://localhost:3000**

### Stop Juice Shop
```bash
# Stop the application
docker compose down

# Or use the convenience script
./stop.sh
```

### Reset Everything
```bash
# Remove all containers, networks, and volumes
./reset.sh
```

## Testing Endpoints & Features

### Authentication & User Management
- **Registration**: `/register` - Create new user accounts
- **Login**: `/login` - User authentication
- **Password Reset**: `/forgot-password` - Password recovery flow
- **User Profile**: `/profile` - User account management

### Product & Shopping Features
- **Homepage**: `/` - Main product catalog
- **Product Search**: `/search?q=<query>` - Search functionality
- **Product Details**: `/detail/<id>` - Individual product pages
- **Shopping Cart**: `/basket` - Cart management
- **Checkout**: `/checkout` - Purchase flow
- **Order History**: `/order-history` - Past orders

### Admin & Management
- **Admin Panel**: `/administration` - Admin interface (requires admin login)
- **User Management**: Admin user controls
- **Product Management**: Admin product controls

### API Endpoints (for automated testing)
- **REST API Base**: `/api/`
- **Products API**: `/api/Products` - GET, POST, PUT, DELETE
- **Users API**: `/api/Users` - User management
- **Authentication API**: `/api/Sessions` - Login/logout
- **Feedback API**: `/api/Feedbacks` - Customer feedback
- **Basket API**: `/api/BasketItems` - Shopping cart items
- **Orders API**: `/api/Orders` - Order management

### File Upload & Media
- **File Upload**: `/file-upload` - Image upload functionality
- **Complaints**: `/complain` - File upload for complaints
- **Profile Pictures**: User avatar uploads

### Forms for Testing
1. **Registration Form** - Email, password, security question
2. **Login Form** - Email/username, password
3. **Search Form** - Product search queries
4. **Feedback Form** - Customer feedback submission
5. **Contact Form** - Customer support inquiries
6. **Address Form** - Shipping address details
7. **Payment Form** - Credit card information
8. **Review Form** - Product reviews and ratings

### Common Test Scenarios
- **SQL Injection**: Various input fields are vulnerable
- **XSS (Cross-Site Scripting)**: Multiple injection points
- **Authentication Bypass**: Weak authentication mechanisms
- **Broken Access Control**: Privilege escalation opportunities
- **File Upload Vulnerabilities**: Unrestricted file uploads
- **CSRF (Cross-Site Request Forgery)**: Missing CSRF protection
- **Sensitive Data Exposure**: Information disclosure issues

## Default Credentials

### Regular Users
- **Email**: `admin@juice-sh.op`
- **Password**: `admin123`

- **Email**: `jim@juice-sh.op`
- **Password**: `ncc-1701`

### Admin Access
- **Email**: `admin@juice-sh.op`
- **Password**: `admin123`

## Health Check

Use the included health check script to verify the application is running:

```bash
./health-check.sh
```

## Logs and Debugging

View application logs:
```bash
docker compose logs -f juice-shop
```

## Security Note

⚠️ **IMPORTANT**: This application is intentionally vulnerable and should NEVER be deployed to a production environment or exposed to the internet. Use only in isolated development/testing environments.

## Useful URLs for Testing

- **Main Application**: http://localhost:3000
- **API Documentation**: http://localhost:3000/api-docs (if available)
- **Score Board**: http://localhost:3000/#/score-board (track solved challenges)
- **Administration**: http://localhost:3000/#/administration

## Integration with QA Tools

This setup is perfect for testing automated QA and security analysis tools. The application provides:

- Multiple form inputs to test
- Various authentication flows
- File upload capabilities
- REST API endpoints
- Different user roles and permissions
- Intentional vulnerabilities for security testing

## Troubleshooting

### Port Already in Use
If port 3000 is occupied, modify the `docker-compose.yml`:
```yaml
ports:
  - "3001:3000"  # Use port 3001 instead
```

### Container Won't Start
Check Docker logs:
```bash
docker compose logs juice-shop
```

### Reset Application State
To start fresh:
```bash
./reset.sh
docker compose up -d
```

## Resources

- [OWASP Juice Shop Official Documentation](https://owasp.org/www-project-juice-shop/)
- [Juice Shop GitHub Repository](https://github.com/juice-shop/juice-shop)
- [OWASP Top 10](https://owasp.org/www-project-top-ten/)
