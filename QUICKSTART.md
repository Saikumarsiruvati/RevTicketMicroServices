# Quick Start Guide - RevTicket Microservices

## Prerequisites Check

Before starting, ensure you have:
- ✅ Java 17 installed (`java -version`)
- ✅ Maven 3.6+ installed (`mvn -version`)
- ✅ MySQL 8.0 running on port 3306
- ✅ MongoDB 7.0 running on port 27017

## Option 1: Quick Start with Docker (Recommended)

### Step 1: Build and Run
```bash
cd D:\RevTicket-MS
docker-compose up --build
```

### Step 2: Wait for Services
Wait 2-3 minutes for all services to start. You'll see:
- ✅ MySQL ready
- ✅ MongoDB ready
- ✅ User Service started
- ✅ Event Service started
- ✅ Booking Service started
- ✅ Payment Service started
- ✅ Notification Service started
- ✅ API Gateway started

### Step 3: Test
Open browser: `http://localhost:8080`

## Option 2: Manual Start (Development)

### Step 1: Start Databases
```bash
# Start MySQL (if not running)
# Default: localhost:3306, user: root, password: 12345

# Start MongoDB (if not running)
# Default: localhost:27017
```

### Step 2: Run Startup Script
```bash
cd D:\RevTicket-MS
start-all-services.bat
```

This will open 6 terminal windows, one for each service.

### Step 3: Verify Services
Wait 1-2 minutes, then check:
- User Service: http://localhost:8081/api/users
- Event Service: http://localhost:8082/api/events
- Booking Service: http://localhost:8083/api/bookings
- Payment Service: http://localhost:8084/api/payments
- Notification Service: http://localhost:8085/api/notifications
- API Gateway: http://localhost:8080

## Testing the Application

### 1. Register a User
```bash
curl -X POST http://localhost:8080/api/auth/signup \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "password": "password123",
    "phone": "1234567890"
  }'
```

### 2. Login
```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

Save the JWT token from response.

### 3. Create an Event
```bash
curl -X POST http://localhost:8080/api/events \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Avengers: Endgame",
    "category": "MOVIES",
    "language": "English",
    "description": "Epic superhero movie",
    "city": "New York",
    "venue": "AMC Theater",
    "dateTime": "2024-12-25T19:00:00",
    "price": 15.99,
    "isActive": true
  }'
```

### 4. Get All Events
```bash
curl http://localhost:8080/api/events
```

### 5. Create a Booking
```bash
curl -X POST http://localhost:8080/api/bookings \
  -H "Content-Type: application/json" \
  -d '{
    "userId": 1,
    "showId": 1,
    "numberOfSeats": 2,
    "seatNumbers": "A1,A2",
    "totalAmount": 31.98
  }'
```

### 6. Process Payment
```bash
curl -X POST http://localhost:8080/api/payments \
  -H "Content-Type: application/json" \
  -d '{
    "bookingId": 1,
    "amount": 31.98,
    "method": "CREDIT_CARD"
  }'
```

## Stopping Services

### Docker:
```bash
docker-compose down
```

### Manual:
Close all terminal windows or press `Ctrl+C` in each window.

## Troubleshooting

### Issue: Port already in use
**Solution**: Check if another application is using ports 8080-8085, 3306, or 27017

### Issue: Database connection failed
**Solution**: 
1. Verify MySQL is running: `mysql -u root -p`
2. Verify MongoDB is running: `mongo`
3. Check credentials in application.properties files

### Issue: Service won't start
**Solution**:
1. Check Java version: `java -version` (should be 17+)
2. Check Maven: `mvn -version`
3. Clean and rebuild: `mvn clean install`

### Issue: Out of memory
**Solution**: Increase JVM heap size:
```bash
export MAVEN_OPTS="-Xmx1024m"
```

## Service Health Checks

Check if services are running:
```bash
# User Service
curl http://localhost:8081/api/users

# Event Service
curl http://localhost:8082/api/events

# Booking Service
curl http://localhost:8083/api/bookings

# Payment Service
curl http://localhost:8084/api/payments

# Notification Service
curl http://localhost:8085/api/notifications
```

## Database Access

### MySQL:
```bash
mysql -u root -p12345
USE user_db;
SHOW TABLES;
```

### MongoDB:
```bash
mongo
use notification_db
show collections
```

## Next Steps

1. ✅ Read [README.md](README.md) for detailed documentation
2. ✅ Read [ARCHITECTURE.md](ARCHITECTURE.md) for architecture details
3. ✅ Explore API endpoints with Postman
4. ✅ Check logs for any errors
5. ✅ Start developing!

## Support

For issues or questions:
1. Check logs in terminal windows
2. Verify database connections
3. Ensure all prerequisites are met
4. Review error messages carefully

## Production Deployment

For production deployment:
1. Update database credentials
2. Configure proper JWT secrets
3. Enable HTTPS
4. Set up monitoring
5. Configure backup strategies
6. Use environment-specific configurations

Happy Coding! 🚀
