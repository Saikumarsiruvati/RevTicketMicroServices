# RevTicket Microservices Architecture

This is a microservices-based implementation of the RevTicket application, migrated from the monolithic architecture.

## Architecture Overview

The application is split into the following microservices:

### 1. **Service Registry** (Port: 8761)
- Eureka Server for service discovery
- Service registration and health monitoring
- Dynamic service location

### 2. **Auth Service** (Port: 8086)
- User authentication and authorization
- JWT token generation and validation
- Password encryption

### 3. **User Service** (Port: 8081)
- User profile management
- User CRUD operations
- Database: MySQL (user_db)

### 4. **Event Service** (Port: 8082)
- Event management (CRUD operations)
- Venue management
- Show scheduling
- Database: MySQL (event_db)

### 5. **Booking Service** (Port: 8083)
- Booking creation and management
- Seat selection and management
- Booking status tracking
- Database: MySQL (booking_db)

### 6. **Payment Service** (Port: 8084)
- Payment processing
- Payment status tracking
- Transaction management
- Database: MySQL (payment_db)

### 7. **Notification Service** (Port: 8085)
- User notifications
- Notification management
- Database: MongoDB (notification_db)

### 8. **Review Service** (Port: 8087)
- Review and rating management
- Event reviews
- Database: MongoDB (review_db)

### 9. **API Gateway** (Port: 8080)
- Single entry point for all services
- Request routing
- CORS configuration

## Technology Stack

### Backend
- **Framework**: Spring Boot 3.2.0
- **Language**: Java 17
- **Databases**: MySQL 8.0, MongoDB 7.0
- **API Gateway**: Spring Cloud Gateway
- **Service Discovery**: Eureka
- **Containerization**: Docker
- **Build Tool**: Maven

### Frontend
- **Framework**: Angular 18
- **UI Library**: Angular Material
- **Language**: TypeScript
- **Port**: 4200

## Prerequisites

- Java 17 or higher
- Maven 3.6+
- MySQL 8.0
- MongoDB 7.0
- Docker & Docker Compose (optional)

## Running Locally

### Option 1: Run Each Service Individually

1. **Start MySQL**:
   ```bash
   # Make sure MySQL is running on localhost:3306
   ```

2. **Start MongoDB**:
   ```bash
   # Make sure MongoDB is running on localhost:27017
   ```

3. **Start each service**:
   ```bash
   # Service Registry
   cd service-registry
   mvn spring-boot:run

   # Auth Service
   cd auth-service
   mvn spring-boot:run

   # User Service
   cd user-service
   mvn spring-boot:run

   # Event Service
   cd event-service
   mvn spring-boot:run

   # Booking Service
   cd booking-service
   mvn spring-boot:run

   # Payment Service
   cd payment-service
   mvn spring-boot:run

   # Notification Service
   cd notification-service
   mvn spring-boot:run

   # Review Service
   cd review-service
   mvn spring-boot:run

   # API Gateway
   cd api-gateway
   mvn spring-boot:run
   ```

### Option 2: Run with Docker Compose

```bash
docker-compose up --build
```

### Option 3: Run Full Application (Backend + Frontend)

```bash
start-full-application.bat
```

This starts all microservices and the frontend.

**Access**:
- Frontend: http://localhost:4200
- API Gateway: http://localhost:8080
- Service Registry: http://localhost:8761

## API Endpoints

All requests go through the API Gateway at `http://localhost:8080`

### Authentication
- `POST /api/auth/login` - User login
- `POST /api/auth/signup` - User registration

### Users
- `GET /api/users/{id}` - Get user by ID
- `GET /api/users/email/{email}` - Get user by email
- `GET /api/users` - Get all users
- `PUT /api/users/{id}` - Update user
- `PUT /api/users/{id}/block` - Block user

### Events
- `GET /api/events` - Get all events
- `GET /api/events/{id}` - Get event by ID
- `POST /api/events` - Create event
- `PUT /api/events/{id}` - Update event
- `DELETE /api/events/{id}` - Delete event

### Bookings
- `POST /api/bookings` - Create booking
- `GET /api/bookings/{id}` - Get booking by ID
- `GET /api/bookings/user/{userId}` - Get user bookings
- `PUT /api/bookings/{id}/confirm` - Confirm booking
- `PUT /api/bookings/{id}/cancel` - Cancel booking

### Payments
- `POST /api/payments` - Process payment
- `GET /api/payments/{paymentId}` - Get payment by ID
- `GET /api/payments/booking/{bookingId}` - Get payment by booking ID

### Notifications
- `POST /api/notifications` - Create notification
- `GET /api/notifications/user/{userId}` - Get user notifications
- `PUT /api/notifications/{id}/read` - Mark notification as read

## Database Configuration

Each service uses its own database:
- **user_db**: User data
- **event_db**: Events, venues, shows
- **booking_db**: Bookings and seats
- **payment_db**: Payment transactions
- **notification_db**: Notifications and reviews (MongoDB)

Default credentials:
- MySQL: root/12345
- MongoDB: No authentication

## Service Communication

Services are designed to be independent. For inter-service communication, you can:
1. Use REST API calls between services
2. Implement message queues (RabbitMQ/Kafka) for async communication
3. Use service discovery (Eureka) for dynamic service location

## Scaling

Each service can be scaled independently:
```bash
docker-compose up --scale user-service=3 --scale event-service=2
```

## Monitoring

Consider adding:
- Spring Boot Actuator for health checks
- Prometheus for metrics
- Grafana for visualization
- ELK Stack for logging

## Migration from Monolithic

Key changes from the monolithic architecture:
1. Separated databases per service
2. Removed direct entity relationships across services
3. Added API Gateway for routing
4. Each service is independently deployable
5. Simplified security configuration per service

## Future Enhancements

- Service discovery with Eureka
- Circuit breaker with Resilience4j
- Distributed tracing with Zipkin
- Centralized configuration with Spring Cloud Config
- Message broker integration (RabbitMQ/Kafka)
- API documentation with Swagger/OpenAPI

## License

This project is part of the RevTicket application.
