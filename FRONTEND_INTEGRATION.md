# Frontend Integration Guide

## Overview

The RevTicket application now has:
- **Backend**: Microservices architecture (9 services)
- **Frontend**: Monolithic Angular application

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│           Frontend (Angular - Port 4200)                 │
│              Monolithic Application                      │
└────────────────────────┬────────────────────────────────┘
                         │ HTTP Requests
                         ▼
┌─────────────────────────────────────────────────────────┐
│              API Gateway (Port 8080)                     │
│                  /api/* routes                           │
└────┬────┬────┬────┬────┬────┬────┬────┬────────────────┘
     │    │    │    │    │    │    │    │
     ▼    ▼    ▼    ▼    ▼    ▼    ▼    ▼
   [Service Registry, Auth, User, Event, Booking, 
    Payment, Notification, Review Services]
```

## Frontend Configuration

### API Endpoint
The frontend is configured to connect to the API Gateway:

**File**: `frontend/src/environments/environment.ts`
```typescript
export const environment = {
  production: false,
  apiUrl: 'http://localhost:8080/api'
};
```

### Port
- **Frontend**: http://localhost:4200
- **API Gateway**: http://localhost:8080

## Running the Application

### Option 1: Full Application (Recommended)
Start both backend and frontend together:

```bash
cd D:\RevTicket-MS
start-full-application.bat
```

This will start:
1. Service Registry (8761)
2. All 8 microservices (8080-8087)
3. Frontend (4200)

### Option 2: Separate Start

**Start Backend First**:
```bash
cd D:\RevTicket-MS
start-all-services.bat
```

**Then Start Frontend**:
```bash
cd D:\RevTicket-MS
start-frontend.bat
```

### Option 3: Docker Compose
```bash
cd D:\RevTicket-MS
docker-compose up --build
```

## Access Points

- **Frontend Application**: http://localhost:4200
- **API Gateway**: http://localhost:8080
- **Service Registry**: http://localhost:8761

## API Routes

All frontend API calls go through the API Gateway at `http://localhost:8080/api`:

### Authentication
- `POST /api/auth/login`
- `POST /api/auth/signup`

### Users
- `GET /api/users/{id}`
- `GET /api/users`
- `PUT /api/users/{id}`

### Events
- `GET /api/events`
- `GET /api/events/{id}`
- `POST /api/events`
- `PUT /api/events/{id}`

### Bookings
- `POST /api/bookings`
- `GET /api/bookings/{id}`
- `GET /api/bookings/user/{userId}`

### Payments
- `POST /api/payments`
- `GET /api/payments/{paymentId}`

### Notifications
- `GET /api/notifications/user/{userId}`
- `POST /api/notifications`

### Reviews
- `GET /api/reviews/event/{eventId}`
- `POST /api/reviews`

## Frontend Features

### User Features
- User Registration & Login
- Browse Events
- View Event Details
- Book Tickets
- Select Seats
- Make Payments
- View Bookings
- View Tickets with QR Code
- Write Reviews

### Admin Features
- Create Events
- Manage Venues
- View Reports
- Manage Users

## Technology Stack

### Frontend
- **Framework**: Angular 18
- **UI Library**: Angular Material
- **State Management**: RxJS
- **HTTP Client**: Angular HttpClient
- **QR Code**: angularx-qrcode

### Backend
- **API Gateway**: Spring Cloud Gateway
- **Microservices**: Spring Boot 3.2.0
- **Databases**: MySQL + MongoDB

## Development

### Frontend Development
```bash
cd frontend
npm install
npm start
```

Frontend will run on http://localhost:4200 with hot reload.

### Backend Development
Each microservice can be started individually:
```bash
cd user-service
mvn spring-boot:run
```

## CORS Configuration

CORS is enabled in the API Gateway for frontend access:

**File**: `api-gateway/src/main/resources/application.yml`
```yaml
globalcors:
  corsConfigurations:
    '[/**]':
      allowedOrigins: "*"
      allowedMethods: "*"
      allowedHeaders: "*"
```

## Testing the Integration

### 1. Start Backend
```bash
start-all-services.bat
```

### 2. Start Frontend
```bash
start-frontend.bat
```

### 3. Open Browser
Navigate to: http://localhost:4200

### 4. Test Flow
1. Register a new user
2. Login
3. Browse events
4. Book a ticket
5. Make payment
6. View booking

## Troubleshooting

### Frontend can't connect to backend
**Issue**: CORS errors or connection refused

**Solution**:
1. Ensure API Gateway is running on port 8080
2. Check browser console for errors
3. Verify environment.ts has correct API URL

### Services not responding
**Issue**: 404 or 500 errors

**Solution**:
1. Check all microservices are running
2. Verify Service Registry at http://localhost:8761
3. Check API Gateway routes in application.yml

### Frontend build errors
**Issue**: npm install or build fails

**Solution**:
```bash
cd frontend
rm -rf node_modules package-lock.json
npm install
```

## Deployment

### Development
- Frontend: `npm start` (port 4200)
- Backend: Individual service startup

### Production
- Frontend: Build and serve with Nginx
- Backend: Docker containers or Kubernetes

### Docker
```bash
docker-compose up --build
```

## Benefits of This Architecture

### Monolithic Frontend
- ✅ Single deployment
- ✅ Easier development
- ✅ Shared state management
- ✅ Consistent UI/UX

### Microservices Backend
- ✅ Independent scaling
- ✅ Technology flexibility
- ✅ Fault isolation
- ✅ Team autonomy

## Future Enhancements

### Frontend
- [ ] Implement microfrontends
- [ ] Add PWA support
- [ ] Implement caching
- [ ] Add offline support

### Backend
- [ ] Add service discovery
- [ ] Implement circuit breaker
- [ ] Add distributed tracing
- [ ] Implement API versioning

## Summary

The application now has:
- **Frontend**: Monolithic Angular app (port 4200)
- **Backend**: 9 microservices (ports 8080-8087, 8761)
- **Integration**: Through API Gateway (port 8080)

All frontend requests go through the API Gateway which routes to appropriate microservices.

**Status**: ✅ Fully Integrated and Ready to Use
