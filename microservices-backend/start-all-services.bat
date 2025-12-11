@echo off
echo Starting RevTicket Microservices Backend...
echo.

echo Starting Service Registry on port 8761...
start "Service Registry" cmd /k "cd service-registry && mvn spring-boot:run"
timeout /t 10

echo Starting Auth Service on port 8086...
start "Auth Service" cmd /k "cd auth-service && mvn spring-boot:run"
timeout /t 5

echo Starting User Service on port 8081...
start "User Service" cmd /k "cd user-service && mvn spring-boot:run"
timeout /t 5

echo Starting Event Service on port 8082...
start "Event Service" cmd /k "cd event-service && mvn spring-boot:run"
timeout /t 5

echo Starting Booking Service on port 8083...
start "Booking Service" cmd /k "cd booking-service && mvn spring-boot:run"
timeout /t 5

echo Starting Payment Service on port 8084...
start "Payment Service" cmd /k "cd payment-service && mvn spring-boot:run"
timeout /t 5

echo Starting Notification Service on port 8085...
start "Notification Service" cmd /k "cd notification-service && mvn spring-boot:run"
timeout /t 5

echo Starting Review Service on port 8087...
start "Review Service" cmd /k "cd review-service && mvn spring-boot:run"
timeout /t 5

echo Starting API Gateway on port 8080...
start "API Gateway" cmd /k "cd api-gateway && mvn spring-boot:run"

echo.
echo All backend services are starting...
echo Service Registry: http://localhost:8761
echo API Gateway: http://localhost:8080
echo.
pause
