# Getting Started with RevTicket Microservices

## 📋 Pre-Flight Checklist

Before you begin, make sure you have everything installed:

### Required Software
- [ ] **Java 17 or higher**
  ```bash
  java -version
  # Should show: java version "17.x.x" or higher
  ```

- [ ] **Maven 3.6 or higher**
  ```bash
  mvn -version
  # Should show: Apache Maven 3.6.x or higher
  ```

- [ ] **MySQL 8.0**
  ```bash
  mysql --version
  # Should show: mysql Ver 8.0.x
  ```

- [ ] **MongoDB 7.0**
  ```bash
  mongo --version
  # Should show: MongoDB shell version v7.0.x
  ```

- [ ] **Docker & Docker Compose** (Optional but recommended)
  ```bash
  docker --version
  docker-compose --version
  ```

## 🚀 Quick Start (3 Options)

### Option 1: Docker Compose (Easiest - Recommended)

**Step 1**: Open terminal in project root
```bash
cd D:\RevTicket-MS
```

**Step 2**: Start everything with one command
```bash
docker-compose up --build
```

**Step 3**: Wait 2-3 minutes for all services to start

**Step 4**: Test the API Gateway
```bash
curl http://localhost:8080/api/events
```

✅ **Done!** All services are running.

---

### Option 2: Windows Batch Script (Local Development)

**Step 1**: Ensure MySQL and MongoDB are running
```bash
# Check MySQL
mysql -u root -p12345 -e "SELECT 1"

# Check MongoDB
mongo --eval "db.version()"
```

**Step 2**: Double-click the startup script
```
D:\RevTicket-MS\start-all-services.bat
```

**Step 3**: Wait for all 6 terminal windows to show "Started" message

**Step 4**: Test the services
```bash
curl http://localhost:8080/api/events
```

✅ **Done!** All services are running locally.

---

### Option 3: Manual Start (For Learning)

**Step 1**: Start MySQL
```bash
# Make sure MySQL is running on localhost:3306
# Username: root
# Password: 12345
```

**Step 2**: Start MongoDB
```bash
# Make sure MongoDB is running on localhost:27017
```

**Step 3**: Start each service in separate terminals

**Terminal 1 - User Service**:
```bash
cd D:\RevTicket-MS\user-service
mvn spring-boot:run
```

**Terminal 2 - Event Service**:
```bash
cd D:\RevTicket-MS\event-service
mvn spring-boot:run
```

**Terminal 3 - Booking Service**:
```bash
cd D:\RevTicket-MS\booking-service
mvn spring-boot:run
```

**Terminal 4 - Payment Service**:
```bash
cd D:\RevTicket-MS\payment-service
mvn spring-boot:run
```

**Terminal 5 - Notification Service**:
```bash
cd D:\RevTicket-MS\notification-service
mvn spring-boot:run
```

**Terminal 6 - API Gateway**:
```bash
cd D:\RevTicket-MS\api-gateway
mvn spring-boot:run
```

**Step 4**: Wait for all services to show "Started" message

✅ **Done!** All services are running.

---

## 🧪 Testing Your Setup

### 1. Check Service Health

**User Service**:
```bash
curl http://localhost:8081/api/users
```

**Event Service**:
```bash
curl http://localhost:8082/api/events
```

**Booking Service**:
```bash
curl http://localhost:8083/api/bookings
```

**Payment Service**:
```bash
curl http://localhost:8084/api/payments
```

**Notification Service**:
```bash
curl http://localhost:8085/api/notifications
```

**API Gateway**:
```bash
curl http://localhost:8080/api/events
```

### 2. Create Your First User

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

**Expected Response**:
```json
{
  "token": "eyJhbGciOiJIUzUxMiJ9...",
  "user": {
    "id": 1,
    "name": "John Doe",
    "email": "john@example.com",
    "role": "USER"
  }
}
```

### 3. Login

```bash
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "email": "john@example.com",
    "password": "password123"
  }'
```

### 4. Create an Event

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

### 5. Get All Events

```bash
curl http://localhost:8080/api/events
```

## 🎯 What's Next?

### For Developers
1. ✅ Read [README.md](README.md) - Main documentation
2. ✅ Read [ARCHITECTURE.md](ARCHITECTURE.md) - Architecture details
3. ✅ Read [QUICKSTART.md](QUICKSTART.md) - Detailed quick start
4. ✅ Explore the code in each service
5. ✅ Try modifying and adding features

### For DevOps
1. ✅ Review [docker-compose.yml](docker-compose.yml)
2. ✅ Check Dockerfile in each service
3. ✅ Set up monitoring (Prometheus + Grafana)
4. ✅ Configure CI/CD pipeline
5. ✅ Plan Kubernetes deployment

### For Architects
1. ✅ Read [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)
2. ✅ Review service boundaries
3. ✅ Plan inter-service communication
4. ✅ Design event-driven architecture
5. ✅ Plan scaling strategy

## 🔧 Common Issues & Solutions

### Issue 1: Port Already in Use
**Error**: `Port 8080 is already in use`

**Solution**:
```bash
# Windows
netstat -ano | findstr :8080
taskkill /PID <PID> /F

# Or change port in application.properties
```

### Issue 2: Database Connection Failed
**Error**: `Unable to connect to MySQL`

**Solution**:
```bash
# Check if MySQL is running
mysql -u root -p12345

# If not, start MySQL service
# Windows: services.msc -> MySQL -> Start
```

### Issue 3: Maven Build Failed
**Error**: `Failed to execute goal`

**Solution**:
```bash
# Clean and rebuild
mvn clean install

# Or skip tests
mvn clean install -DskipTests
```

### Issue 4: Out of Memory
**Error**: `Java heap space`

**Solution**:
```bash
# Increase heap size
set MAVEN_OPTS=-Xmx1024m
mvn spring-boot:run
```

### Issue 5: Docker Build Failed
**Error**: `Cannot connect to Docker daemon`

**Solution**:
```bash
# Start Docker Desktop
# Then retry
docker-compose up --build
```

## 📊 Service Ports Reference

| Service | Port | URL |
|---------|------|-----|
| API Gateway | 8080 | http://localhost:8080 |
| User Service | 8081 | http://localhost:8081 |
| Event Service | 8082 | http://localhost:8082 |
| Booking Service | 8083 | http://localhost:8083 |
| Payment Service | 8084 | http://localhost:8084 |
| Notification Service | 8085 | http://localhost:8085 |
| MySQL | 3306 | localhost:3306 |
| MongoDB | 27017 | localhost:27017 |

## 🗄️ Database Credentials

### MySQL
- **Host**: localhost
- **Port**: 3306
- **Username**: root
- **Password**: 12345
- **Databases**: user_db, event_db, booking_db, payment_db

### MongoDB
- **Host**: localhost
- **Port**: 27017
- **Database**: notification_db
- **Authentication**: None (default)

## 📱 Using Postman

### Import Collection
1. Open Postman
2. Click Import
3. Create new collection: "RevTicket Microservices"
4. Add requests for each endpoint

### Sample Requests

**1. Signup**
- Method: POST
- URL: http://localhost:8080/api/auth/signup
- Body (JSON):
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "password123",
  "phone": "1234567890"
}
```

**2. Login**
- Method: POST
- URL: http://localhost:8080/api/auth/login
- Body (JSON):
```json
{
  "email": "john@example.com",
  "password": "password123"
}
```

**3. Get Events**
- Method: GET
- URL: http://localhost:8080/api/events

**4. Create Event**
- Method: POST
- URL: http://localhost:8080/api/events
- Body (JSON):
```json
{
  "title": "Concert Night",
  "category": "CONCERTS",
  "city": "New York",
  "price": 50.00
}
```

## 🎓 Learning Path

### Week 1: Understanding
- [ ] Read all documentation
- [ ] Understand microservices architecture
- [ ] Run all services locally
- [ ] Test all endpoints

### Week 2: Development
- [ ] Add new endpoint to existing service
- [ ] Create new feature
- [ ] Write unit tests
- [ ] Debug issues

### Week 3: Advanced
- [ ] Add service discovery
- [ ] Implement circuit breaker
- [ ] Add distributed tracing
- [ ] Set up monitoring

### Week 4: Production
- [ ] Deploy to Docker
- [ ] Set up CI/CD
- [ ] Configure logging
- [ ] Performance testing

## 🆘 Getting Help

### Documentation
1. Check [README.md](README.md)
2. Check [QUICKSTART.md](QUICKSTART.md)
3. Check [ARCHITECTURE.md](ARCHITECTURE.md)
4. Check [MIGRATION_GUIDE.md](MIGRATION_GUIDE.md)

### Debugging
1. Check service logs in terminal
2. Check database connections
3. Verify port availability
4. Check application.properties

### Community
1. Stack Overflow
2. Spring Boot Documentation
3. Docker Documentation
4. GitHub Issues

## ✅ Success Checklist

After setup, you should be able to:
- [ ] Access API Gateway at http://localhost:8080
- [ ] Register a new user
- [ ] Login and get JWT token
- [ ] Create an event
- [ ] View all events
- [ ] Create a booking
- [ ] Process a payment
- [ ] View notifications

## 🎉 Congratulations!

You've successfully set up the RevTicket Microservices application!

**Next Steps**:
1. Explore the code
2. Try adding new features
3. Experiment with different configurations
4. Deploy to cloud (AWS, Azure, GCP)

**Happy Coding! 🚀**

---

**Need Help?** Check the documentation or review the code comments.
