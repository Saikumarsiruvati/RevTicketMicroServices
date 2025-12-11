# Backend Integration Guide

## Overview
The frontend has been updated to connect to the Spring Boot backend API. All services now make HTTP requests to the backend instead of using mock data.

## Backend Requirements
Ensure your Spring Boot backend is running on `http://localhost:8080` with the following API endpoints:

### Authentication Endpoints
- `POST /api/auth/login` - User login
- `POST /api/auth/register` - User registration

### Event Endpoints
- `GET /api/events` - Get all events
- `GET /api/events/category/{category}` - Get events by category
- `GET /api/events/{id}` - Get event by ID
- `GET /api/events/search?q={query}` - Search events
- `POST /api/admin/events` - Create event (admin only)
- `PUT /api/admin/events/{id}` - Update event (admin only)
- `DELETE /api/admin/events/{id}` - Delete event (admin only)

### Show Endpoints
- `GET /api/shows/event/{eventId}` - Get shows for an event

### Seat Endpoints
- `GET /api/seats/show/{showId}` - Get seat layout for a show
- `POST /api/seats/lock` - Lock seats temporarily
- `POST /api/seats/unlock` - Unlock seats

### Booking Endpoints
- `POST /api/bookings` - Create booking
- `GET /api/bookings/user` - Get user bookings
- `GET /api/bookings/{id}` - Get booking by ID
- `DELETE /api/bookings/{id}` - Cancel booking

### Payment Endpoints
- `POST /api/payments/process` - Process payment

### User Endpoints
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update user profile

### Venue Endpoints
- `GET /api/venues` - Get all venues
- `POST /api/admin/venues` - Create venue (admin only)
- `PUT /api/admin/venues/{id}` - Update venue (admin only)
- `DELETE /api/admin/venues/{id}` - Delete venue (admin only)

## Configuration
The API base URL is configured in:
- `src/environments/environment.ts` (development)
- `src/environments/environment.prod.ts` (production)

Default URL: `http://localhost:8080/api`

## Features Added
1. **HTTP Interceptors**: 
   - Auth interceptor automatically adds JWT tokens to requests
   - Error interceptor handles API errors and shows user-friendly messages

2. **Error Handling**: 
   - Shows notification when backend is not running
   - Handles 401 unauthorized errors by redirecting to login
   - Displays error messages from backend

3. **JWT Authentication**: 
   - Tokens are automatically attached to API requests
   - Stored in localStorage for persistence

## Starting the Application
1. Ensure Spring Boot backend is running on port 8080
2. Start the Angular frontend: `ng serve`
3. Navigate to `http://localhost:4200`

## Troubleshooting
- If you see "Backend server is not running" message, ensure Spring Boot is started
- Check browser console for detailed error messages
- Verify API endpoints match the backend implementation