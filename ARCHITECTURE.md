# RevTicket Microservices Architecture

## System Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         Client Applications                      │
│                    (Web Browser / Mobile App)                    │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             │ HTTP/REST
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                       API Gateway (8080)                         │
│                   Spring Cloud Gateway                           │
│                  - Request Routing                               │
│                  - CORS Configuration                            │
└─────┬──────┬──────┬──────┬──────┬─────────────────────────────┘
      │      │      │      │      │
      ▼      ▼      ▼      ▼      ▼
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌──────────────┐
│  User   │ │  Event  │ │ Booking │ │ Payment │ │Notification  │
│ Service │ │ Service │ │ Service │ │ Service │ │  Service     │
│ (8081)  │ │ (8082)  │ │ (8083)  │ │ (8084)  │ │  (8085)      │
└────┬────┘ └────┬────┘ └────┬────┘ └────┬────┘ └──────┬───────┘
     │           │           │           │              │
     ▼           ▼           ▼           ▼              ▼
┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌──────────────┐
│  MySQL  │ │  MySQL  │ │  MySQL  │ │  MySQL  │ │   MongoDB    │
│ user_db │ │event_db │ │booking  │ │payment  │ │notification  │
│         │ │         │ │  _db    │ │  _db    │ │     _db      │
└─────────┘ └─────────┘ └─────────┘ └─────────┘ └──────────────┘
```

## Service Responsibilities

### 1. User Service
**Port**: 8081  
**Database**: MySQL (user_db)  
**Responsibilities**:
- User registration and authentication
- JWT token generation and validation
- User profile management
- User role management (USER/ADMIN)
- Account blocking/unblocking

**Key Endpoints**:
- POST /api/auth/login
- POST /api/auth/signup
- GET /api/users/{id}
- PUT /api/users/{id}

### 2. Event Service
**Port**: 8082  
**Database**: MySQL (event_db)  
**Responsibilities**:
- Event CRUD operations
- Venue management
- Show scheduling
- Event categorization (Movies, Concerts, Sports, Comedy)

**Key Endpoints**:
- GET /api/events
- POST /api/events
- GET /api/events/{id}
- PUT /api/events/{id}

### 3. Booking Service
**Port**: 8083  
**Database**: MySQL (booking_db)  
**Responsibilities**:
- Booking creation and management
- Seat allocation and management
- Booking status tracking (PENDING, CONFIRMED, CANCELLED)
- Seat availability management

**Key Endpoints**:
- POST /api/bookings
- GET /api/bookings/{id}
- GET /api/bookings/user/{userId}
- PUT /api/bookings/{id}/confirm

### 4. Payment Service
**Port**: 8084  
**Database**: MySQL (payment_db)  
**Responsibilities**:
- Payment processing
- Payment status tracking (PENDING, SUCCESS, FAILED, REFUNDED)
- Payment method management
- Transaction history

**Key Endpoints**:
- POST /api/payments
- GET /api/payments/{paymentId}
- GET /api/payments/booking/{bookingId}

### 5. Notification Service
**Port**: 8085  
**Database**: MongoDB (notification_db)  
**Responsibilities**:
- User notification management
- Review and rating system
- Notification read/unread status
- Event reviews

**Key Endpoints**:
- POST /api/notifications
- GET /api/notifications/user/{userId}
- PUT /api/notifications/{id}/read

### 6. API Gateway
**Port**: 8080  
**Technology**: Spring Cloud Gateway  
**Responsibilities**:
- Single entry point for all client requests
- Request routing to appropriate microservices
- CORS configuration
- Load balancing (future)
- Authentication/Authorization (future)

## Data Flow Examples

### 1. User Registration Flow
```
Client → API Gateway → User Service → MySQL (user_db)
                          ↓
                    Generate JWT Token
                          ↓
                    Return to Client
```

### 2. Booking Flow
```
Client → API Gateway → Booking Service → MySQL (booking_db)
                          ↓
                    Create Booking (PENDING)
                          ↓
Client → API Gateway → Payment Service → MySQL (payment_db)
                          ↓
                    Process Payment
                          ↓
Client → API Gateway → Booking Service → Update Status (CONFIRMED)
                          ↓
Client → API Gateway → Notification Service → MongoDB
                          ↓
                    Create Notification
```

### 3. Event Search Flow
```
Client → API Gateway → Event Service → MySQL (event_db)
                          ↓
                    Retrieve Events
                          ↓
                    Return to Client
```

## Database Schema per Service

### User Service (MySQL)
- **users**: id, name, email, password, phone, role, isBlocked

### Event Service (MySQL)
- **events**: id, title, category, language, description, city, venue, dateTime, price, isActive
- **venues**: id, name, city, address, totalSeats, type, isActive
- **shows**: id, eventId, venueId, showTime, availableSeats, isActive

### Booking Service (MySQL)
- **bookings**: id, userId, showId, numberOfSeats, seatNumbers, totalAmount, status, bookingDate, paymentId
- **seats**: id, showId, seatNumber, seatType, status, bookingId

### Payment Service (MySQL)
- **payments**: id, paymentId, bookingId, amount, status, method, paymentDate

### Notification Service (MongoDB)
- **notifications**: id, userId, message, type, isRead, createdAt
- **reviews**: id, eventId, userId, rating, comment, createdAt

## Communication Patterns

### Synchronous Communication
- REST API calls between services
- Used for immediate responses
- Example: Booking Service → Payment Service

### Asynchronous Communication (Future Enhancement)
- Message queues (RabbitMQ/Kafka)
- Event-driven architecture
- Example: Payment Success → Notification Service

## Deployment Strategy

### Local Development
- Each service runs on different port
- Shared MySQL and MongoDB instances
- Direct service-to-service communication

### Docker Deployment
- Each service in separate container
- Isolated databases per service
- Docker network for inter-service communication

### Production (Future)
- Kubernetes orchestration
- Service mesh (Istio)
- Distributed tracing
- Centralized logging

## Security Considerations

### Current Implementation
- JWT-based authentication in User Service
- CORS enabled in API Gateway
- Password encryption with BCrypt

### Future Enhancements
- OAuth2 integration
- API rate limiting
- Request validation
- Secrets management (Vault)

## Scalability

Each service can be scaled independently based on load:
- **User Service**: Scale during peak registration times
- **Event Service**: Scale during event browsing
- **Booking Service**: Scale during ticket sales
- **Payment Service**: Scale during payment processing
- **Notification Service**: Scale for bulk notifications

## Monitoring & Observability

### Recommended Tools
- **Health Checks**: Spring Boot Actuator
- **Metrics**: Prometheus
- **Visualization**: Grafana
- **Logging**: ELK Stack (Elasticsearch, Logstash, Kibana)
- **Tracing**: Zipkin/Jaeger

## Advantages of Microservices Architecture

1. **Independent Deployment**: Each service can be deployed separately
2. **Technology Flexibility**: Different services can use different technologies
3. **Scalability**: Scale only the services that need it
4. **Fault Isolation**: Failure in one service doesn't affect others
5. **Team Autonomy**: Different teams can work on different services
6. **Database per Service**: Each service owns its data

## Challenges & Solutions

### Challenge 1: Data Consistency
**Solution**: Implement eventual consistency with event sourcing

### Challenge 2: Service Discovery
**Solution**: Use Eureka or Consul for dynamic service registration

### Challenge 3: Distributed Transactions
**Solution**: Implement Saga pattern for distributed transactions

### Challenge 4: Testing
**Solution**: Contract testing with Pact, integration tests

### Challenge 5: Monitoring
**Solution**: Centralized logging and distributed tracing
