# Migration Guide: Monolithic to Microservices

## Overview

This document explains the migration from the monolithic RevTicket application to a microservices architecture.

## Architecture Comparison

### Monolithic Architecture (Original)
```
┌─────────────────────────────────────────┐
│      RevTickets Backend (8080)          │
│  ┌────────────────────────────────────┐ │
│  │  Controllers (All in one)          │ │
│  │  - AuthController                  │ │
│  │  - UserController                  │ │
│  │  - EventController                 │ │
│  │  - BookingController               │ │
│  │  - PaymentController               │ │
│  │  - NotificationController          │ │
│  └────────────────────────────────────┘ │
│  ┌────────────────────────────────────┐ │
│  │  Services (All in one)             │ │
│  └────────────────────────────────────┘ │
│  ┌────────────────────────────────────┐ │
│  │  Repositories (All in one)         │ │
│  └────────────────────────────────────┘ │
└─────────────────┬───────────────────────┘
                  │
        ┌─────────┴─────────┐
        ▼                   ▼
    ┌────────┐         ┌─────────┐
    │ MySQL  │         │ MongoDB │
    └────────┘         └─────────┘
```

### Microservices Architecture (New)
```
┌──────────────────────────────────────────────────────┐
│              API Gateway (8080)                       │
└────┬────┬────┬────┬────┬──────────────────────────┘
     │    │    │    │    │
     ▼    ▼    ▼    ▼    ▼
   ┌───┐┌───┐┌───┐┌───┐┌───┐
   │US ││ES ││BS ││PS ││NS │  (Services)
   └─┬─┘└─┬─┘└─┬─┘└─┬─┘└─┬─┘
     │    │    │    │    │
     ▼    ▼    ▼    ▼    ▼
   ┌───┐┌───┐┌───┐┌───┐┌───┐
   │DB1││DB2││DB3││DB4││DB5│  (Databases)
   └───┘└───┘└───┘└───┘└───┘
```

## Key Changes

### 1. Database Separation

**Before (Monolithic)**:
- Single MySQL database: `revtickets`
- Single MongoDB database: `revtickets`
- All tables in one database
- Direct foreign key relationships

**After (Microservices)**:
- MySQL databases: `user_db`, `event_db`, `booking_db`, `payment_db`
- MongoDB database: `notification_db`
- Each service has its own database
- No direct foreign key relationships across services

### 2. Code Organization

**Before**:
```
revtickets-backend/
├── controller/
│   ├── AuthController.java
│   ├── UserController.java
│   ├── EventController.java
│   ├── BookingController.java
│   ├── PaymentController.java
│   └── NotificationController.java
├── service/
├── repository/
└── model/
```

**After**:
```
user-service/
├── controller/
│   ├── AuthController.java
│   └── UserController.java
├── service/
├── repository/
└── model/

event-service/
├── controller/
│   └── EventController.java
├── service/
├── repository/
└── model/

(Similar structure for other services)
```

### 3. Entity Relationships

**Before (Monolithic)**:
```java
@Entity
public class Booking {
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;  // Direct relationship
    
    @ManyToOne
    @JoinColumn(name = "show_id")
    private Show show;  // Direct relationship
}
```

**After (Microservices)**:
```java
@Entity
public class Booking {
    @Column(nullable = false)
    private Long userId;  // Reference by ID only
    
    @Column(nullable = false)
    private Long showId;  // Reference by ID only
}
```

### 4. Configuration

**Before (Monolithic)**:
```properties
# Single application.properties
server.port=8080
spring.datasource.url=jdbc:mysql://localhost:3306/revtickets
spring.data.mongodb.uri=mongodb://localhost:27017/revtickets
```

**After (Microservices)**:
```properties
# user-service/application.properties
server.port=8081
spring.datasource.url=jdbc:mysql://localhost:3306/user_db

# event-service/application.properties
server.port=8082
spring.datasource.url=jdbc:mysql://localhost:3306/event_db

# (Separate config for each service)
```

### 5. Security Configuration

**Before (Monolithic)**:
- Complex WebSecurityConfig with multiple filters
- JWT filter applied globally
- OAuth2 configuration in main application

**After (Microservices)**:
- Simplified security per service
- JWT validation only in User Service
- API Gateway handles routing
- Each service can have its own security rules

## Migration Steps

### Step 1: Identify Service Boundaries
- ✅ User management → User Service
- ✅ Event & venue management → Event Service
- ✅ Booking & seats → Booking Service
- ✅ Payments → Payment Service
- ✅ Notifications & reviews → Notification Service

### Step 2: Extract Models
- Copy relevant entity classes to each service
- Remove cross-service relationships
- Replace entity references with IDs

### Step 3: Extract Repositories
- Copy relevant repository interfaces
- Update to work with new entity structure

### Step 4: Extract Services
- Copy business logic to appropriate service
- Remove cross-service dependencies
- Add REST calls for inter-service communication

### Step 5: Extract Controllers
- Copy controller classes
- Update request mappings
- Ensure proper CORS configuration

### Step 6: Create API Gateway
- Set up Spring Cloud Gateway
- Configure routes to each service
- Add CORS configuration

### Step 7: Database Migration
- Create separate databases
- Migrate data from monolithic database
- Update connection strings

## Data Migration

### User Data
```sql
-- From monolithic
SELECT * FROM revtickets.users;

-- To microservices
INSERT INTO user_db.users SELECT * FROM revtickets.users;
```

### Event Data
```sql
-- From monolithic
SELECT * FROM revtickets.events;
SELECT * FROM revtickets.venues;
SELECT * FROM revtickets.shows;

-- To microservices
INSERT INTO event_db.events SELECT * FROM revtickets.events;
INSERT INTO event_db.venues SELECT * FROM revtickets.venues;
INSERT INTO event_db.shows SELECT * FROM revtickets.shows;
```

### Booking Data
```sql
-- From monolithic
SELECT * FROM revtickets.bookings;
SELECT * FROM revtickets.seats;

-- To microservices
INSERT INTO booking_db.bookings SELECT * FROM revtickets.bookings;
INSERT INTO booking_db.seats SELECT * FROM revtickets.seats;
```

### Payment Data
```sql
-- From monolithic
SELECT * FROM revtickets.payments;

-- To microservices
INSERT INTO payment_db.payments SELECT * FROM revtickets.payments;
```

### Notification Data (MongoDB)
```javascript
// From monolithic
db.notifications.find()
db.reviews.find()

// To microservices (same structure, different database)
// Use mongodump and mongorestore
mongodump --db revtickets --collection notifications
mongorestore --db notification_db --collection notifications
```

## Breaking Changes

### 1. API Endpoints
**Before**: `http://localhost:8080/api/users`  
**After**: `http://localhost:8080/api/users` (through gateway)

No breaking changes for clients! API Gateway maintains same endpoints.

### 2. Direct Database Access
**Before**: All services could access all tables  
**After**: Each service only accesses its own database

### 3. Transaction Management
**Before**: Single database transactions  
**After**: Distributed transactions (requires Saga pattern)

## Advantages Gained

### 1. Independent Deployment
- Deploy User Service without affecting Event Service
- Faster deployment cycles
- Reduced risk

### 2. Independent Scaling
- Scale Booking Service during high traffic
- Scale Payment Service during payment processing
- Cost-effective resource utilization

### 3. Technology Flexibility
- User Service: MySQL + JWT
- Notification Service: MongoDB
- Future: Could use different languages/frameworks

### 4. Team Autonomy
- Team A: User & Auth
- Team B: Events & Venues
- Team C: Bookings & Payments
- Parallel development

### 5. Fault Isolation
- If Payment Service fails, users can still browse events
- Better resilience
- Graceful degradation

## Challenges & Solutions

### Challenge 1: Data Consistency
**Problem**: No foreign keys across services  
**Solution**: 
- Eventual consistency
- Event-driven architecture
- Saga pattern for distributed transactions

### Challenge 2: Service Communication
**Problem**: Services need to communicate  
**Solution**:
- REST API calls
- Message queues (future)
- Service mesh (future)

### Challenge 3: Testing
**Problem**: More complex testing  
**Solution**:
- Unit tests per service
- Integration tests
- Contract testing
- End-to-end tests

### Challenge 4: Monitoring
**Problem**: Multiple services to monitor  
**Solution**:
- Centralized logging (ELK)
- Distributed tracing (Zipkin)
- Metrics (Prometheus + Grafana)

### Challenge 5: Development Complexity
**Problem**: Running multiple services locally  
**Solution**:
- Docker Compose
- Startup scripts
- Service mocking

## Performance Considerations

### Latency
- **Monolithic**: Single internal call
- **Microservices**: Network call between services
- **Mitigation**: Caching, async communication

### Database Queries
- **Monolithic**: JOIN queries across tables
- **Microservices**: Multiple service calls
- **Mitigation**: Data denormalization, caching

### Network Overhead
- **Monolithic**: No network calls
- **Microservices**: REST API calls
- **Mitigation**: gRPC, message queues

## Best Practices

### 1. Service Design
- Keep services small and focused
- One database per service
- Avoid chatty communication

### 2. API Design
- RESTful endpoints
- Versioning (v1, v2)
- Proper error handling

### 3. Data Management
- Event sourcing for audit trail
- CQRS for read/write separation
- Eventual consistency

### 4. Security
- JWT tokens
- API Gateway authentication
- Service-to-service authentication

### 5. Monitoring
- Health checks
- Metrics collection
- Distributed tracing
- Centralized logging

## Future Enhancements

### Phase 1 (Current)
- ✅ Basic microservices
- ✅ API Gateway
- ✅ Separate databases

### Phase 2 (Next)
- ⏳ Service discovery (Eureka)
- ⏳ Circuit breaker (Resilience4j)
- ⏳ Distributed tracing (Zipkin)

### Phase 3 (Future)
- ⏳ Message queues (RabbitMQ/Kafka)
- ⏳ Event sourcing
- ⏳ CQRS pattern

### Phase 4 (Advanced)
- ⏳ Service mesh (Istio)
- ⏳ Kubernetes deployment
- ⏳ Auto-scaling

## Rollback Strategy

If issues arise:

### Option 1: Gradual Rollback
1. Route traffic back to monolithic
2. Keep microservices running
3. Fix issues
4. Re-route traffic

### Option 2: Complete Rollback
1. Stop all microservices
2. Restore monolithic application
3. Migrate data back
4. Resume operations

### Option 3: Hybrid Approach
1. Keep some services in microservices
2. Route others to monolithic
3. Gradual migration

## Conclusion

The migration from monolithic to microservices provides:
- ✅ Better scalability
- ✅ Independent deployment
- ✅ Technology flexibility
- ✅ Team autonomy
- ✅ Fault isolation

While introducing:
- ⚠️ Increased complexity
- ⚠️ Network latency
- ⚠️ Distributed transactions
- ⚠️ More monitoring needed

The benefits outweigh the challenges for a growing application like RevTicket.
