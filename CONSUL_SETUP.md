# Consul Setup Guide for RevTicket

## Step 1: Download Consul

1. Go to https://www.consul.io/downloads
2. Download Consul for Windows
3. Extract the `consul.exe` file to a folder (e.g., `C:\consul\`)

## Step 2: Start Consul

Open Command Prompt and run:

```bash
cd C:\consul
consul agent -dev
```

This starts Consul in development mode on:
- **HTTP API**: http://localhost:8500
- **UI**: http://localhost:8500/ui

## Step 3: Verify Consul is Running

Open browser and go to: http://localhost:8500/ui

You should see the Consul dashboard.

## Step 4: Start Your Services

All services are now configured to use Consul. Start them in order:

```bash
# 1. Start Auth Service
cd microservices-backend\auth-service
mvn spring-boot:run

# 2. Start User Service
cd microservices-backend\user-service
mvn spring-boot:run

# 3. Start Event Service
cd microservices-backend\event-service
mvn spring-boot:run

# 4. Start Booking Service
cd microservices-backend\booking-service
mvn spring-boot:run

# 5. Start Payment Service
cd microservices-backend\payment-service
mvn spring-boot:run

# 6. Start Notification Service
cd microservices-backend\notification-service
mvn spring-boot:run

# 7. Start Review Service
cd microservices-backend\review-service
mvn spring-boot:run

# 8. Start API Gateway
cd microservices-backend\api-gateway
mvn spring-boot:run
```

## Step 5: Verify Services in Consul

Go to http://localhost:8500/ui/dc1/services

You should see all services registered:
- auth-service
- user-service
- event-service
- booking-service
- payment-service
- notification-service
- review-service
- api-gateway

## What Changed

✅ **Enabled Consul** in all service application.properties files
✅ **Consul host**: localhost
✅ **Consul port**: 8500
✅ **Health checks**: Every 10 seconds
✅ **Service discovery**: Enabled

## Eureka vs Consul

**Before (Eureka):**
- Service Registry on port 8761
- Eureka dashboard

**Now (Consul):**
- Consul on port 8500
- Consul UI with service mesh capabilities
- Better health checking
- Key-value store included

## Troubleshooting

**If services don't register:**
1. Make sure Consul is running: `consul members`
2. Check service logs for connection errors
3. Verify port 8500 is not blocked

**If Consul won't start:**
- Make sure no other service is using port 8500
- Run as Administrator if needed

## Stop Consul

Press `Ctrl+C` in the Consul terminal window.

## Notes

- You can now stop the Eureka service-registry (port 8761) - it's no longer needed
- All services will automatically register with Consul on startup
- Consul provides better service discovery and health monitoring than Eureka
