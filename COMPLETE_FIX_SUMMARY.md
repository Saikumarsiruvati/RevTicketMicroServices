# Complete Fix Summary - RevTicket Microservices

## Issues Fixed

### 1. Show Creation (400 Bad Request)
**Problem**: Frontend was sending nested objects `{event: {id: x}, venue: {id: y}}` but backend expected flat IDs `{eventId: x, venueId: y}`

**Fix**: Updated `admin-dashboard.component.ts` createShow() method to send:
```javascript
{
  eventId: Number(this.newShow.eventId),
  venueId: 1,
  showTime: this.newShow.showTime,
  availableSeats: this.newShow.availableSeats,
  isActive: true
}
```

### 2. Missing Backend Endpoints
Added the following endpoints:

#### Booking Service
- `DELETE /api/bookings/{id}` - Delete booking
- `POST /api/seats/generate/{showId}/{count}` - Generate seats for a show

#### User Service
- `PUT /api/users/{id}/unblock` - Unblock user

#### Auth Service
- `POST /api/auth/google` - Google OAuth login

### 3. Frontend Service URLs
**Problem**: Frontend was using `/admin/events`, `/admin/users` prefixes

**Fix**: Updated `event.service.ts` to use correct paths:
- `/api/events` instead of `/api/admin/events`
- `/api/users` instead of `/api/admin/users`

## Complete Setup Instructions

### Step 1: Ensure Databases are Running
```bash
# MySQL should be running on localhost:3306
# MongoDB should be running on localhost:27017
```

### Step 2: Create Databases
Run the SQL script:
```sql
CREATE DATABASE IF NOT EXISTS user_db;
CREATE DATABASE IF NOT EXISTS event_db;
CREATE DATABASE IF NOT EXISTS booking_db;
CREATE DATABASE IF NOT EXISTS payment_db;
```

### Step 3: Rebuild All Services
```bash
cd d:\RevTicket-MS
rebuild-all.bat
```

This will:
1. Clean and build all 9 microservices
2. Skip tests for faster build
3. Automatically start all services after build

### Step 4: Start Frontend
```bash
cd monolithic-frontend
npm install
npm start
```

## Service Ports

| Service | Port | URL |
|---------|------|-----|
| Service Registry | 8761 | http://localhost:8761 |
| API Gateway | 8080 | http://localhost:8080 |
| Auth Service | 8086 | http://localhost:8086 |
| User Service | 8081 | http://localhost:8081 |
| Event Service | 8082 | http://localhost:8082 |
| Booking Service | 8083 | http://localhost:8083 |
| Payment Service | 8084 | http://localhost:8084 |
| Notification Service | 8085 | http://localhost:8085 |
| Review Service | 8087 | http://localhost:8087 |
| Frontend | 4200 | http://localhost:4200 |

## API Endpoints (via Gateway - localhost:8080)

### Authentication
- `POST /api/auth/login` - Login
- `POST /api/auth/signup` - Register
- `POST /api/auth/google` - Google login

### Users
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `GET /api/users/email/{email}` - Get user by email
- `PUT /api/users/{id}` - Update user
- `PUT /api/users/{id}/block` - Block user
- `PUT /api/users/{id}/unblock` - Unblock user

### Events
- `GET /api/events` - Get all events
- `GET /api/events/{id}` - Get event by ID
- `GET /api/events/category/{category}` - Get events by category
- `POST /api/events` - Create event
- `PUT /api/events/{id}` - Update event
- `DELETE /api/events/{id}` - Delete event

### Shows
- `GET /api/shows` - Get all shows
- `GET /api/shows/event/{eventId}` - Get shows by event
- `POST /api/shows` - Create show
- `DELETE /api/shows/{id}` - Delete show

### Venues
- `GET /api/venues` - Get all venues
- `GET /api/venues/{id}` - Get venue by ID
- `POST /api/venues` - Create venue
- `PUT /api/venues/{id}` - Update venue
- `DELETE /api/venues/{id}` - Delete venue

### Bookings
- `GET /api/bookings` - Get all bookings
- `GET /api/bookings/{id}` - Get booking by ID
- `GET /api/bookings/user/{userId}` - Get user bookings
- `POST /api/bookings` - Create booking
- `PUT /api/bookings/{id}/confirm` - Confirm booking
- `PUT /api/bookings/{id}/cancel` - Cancel booking
- `DELETE /api/bookings/{id}` - Delete booking

### Seats
- `GET /api/seats/show/{showId}` - Get seats for show
- `POST /api/seats/generate/{showId}/{count}` - Generate seats

### Payments
- `POST /api/payments` - Process payment
- `GET /api/payments/{id}` - Get payment by ID
- `GET /api/payments/booking/{bookingId}` - Get payment by booking

### Notifications
- `POST /api/notifications` - Create notification
- `GET /api/notifications/user/{userId}` - Get user notifications
- `PUT /api/notifications/{id}/read` - Mark as read

### Reviews
- `POST /api/reviews` - Create review
- `GET /api/reviews/event/{eventId}` - Get event reviews
- `GET /api/reviews/user/{userId}` - Get user reviews

## Testing Workflow

### 1. User Registration & Login
1. Go to http://localhost:4200
2. Click "Sign Up"
3. Register with email/password or Google
4. Login with credentials

### 2. Admin Functions (login as admin@revtickets.com)
1. Navigate to Admin Dashboard
2. **Create Event**: Fill form and submit
3. **Create Show**: Select event, date/time, seats
4. **Generate Seats**: Select show, enter seat count
5. **Manage Users**: Block/unblock users
6. **View Bookings**: See all bookings, cancel/delete

### 3. User Functions
1. Browse events on home page
2. Click event to see details
3. Select show and seats
4. Complete booking
5. Make payment
6. View booking history

## Common Issues & Solutions

### Issue: Service won't start
**Solution**: Check if port is already in use. Kill process and restart.

### Issue: Database connection error
**Solution**: Ensure MySQL/MongoDB are running and databases are created.

### Issue: 404 Not Found
**Solution**: Check API Gateway is running on port 8080 and routes are configured.

### Issue: CORS error
**Solution**: API Gateway has CORS enabled for all origins. Check gateway logs.

### Issue: 401 Unauthorized
**Solution**: Ensure JWT token is being sent in Authorization header.

## Default Credentials

### Admin Account
- Email: admin@revtickets.com
- Password: admin123

### Database
- MySQL: root/12345
- MongoDB: No authentication

## Build Commands

### Build Single Service
```bash
cd microservices-backend/{service-name}
mvn clean package -DskipTests
mvn spring-boot:run
```

### Build All Services
```bash
cd d:\RevTicket-MS
rebuild-all.bat
```

### Start All Services
```bash
cd d:\RevTicket-MS
start-all-services.bat
```

### Start Frontend
```bash
cd monolithic-frontend
npm start
```

## Architecture Notes

- **API Gateway**: Single entry point, routes to services
- **Service Registry**: Eureka for service discovery
- **Auth Service**: JWT token generation/validation
- **Independent Databases**: Each service has its own DB
- **RESTful Communication**: Services communicate via REST APIs
- **Stateless**: No session state, JWT for authentication

## Next Steps

1. Add proper error handling and validation
2. Implement circuit breaker (Resilience4j)
3. Add distributed tracing (Zipkin)
4. Implement centralized logging (ELK)
5. Add API documentation (Swagger)
6. Implement rate limiting
7. Add caching (Redis)
8. Implement message queue (RabbitMQ/Kafka)

## Support

For issues, check:
1. Service logs in terminal windows
2. API Gateway logs for routing issues
3. Database connectivity
4. Port conflicts
5. Frontend console for errors
