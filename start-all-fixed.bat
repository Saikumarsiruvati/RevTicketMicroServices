@echo off
echo Killing all existing Java processes...
taskkill /F /IM java.exe 2>nul
timeout /t 3

cd microservices-backend

echo Starting Service Registry...
start "Service Registry" cmd /k "cd service-registry && mvn spring-boot:run"
timeout /t 20

echo Starting Auth Service...
start "Auth Service" cmd /k "cd auth-service && mvn spring-boot:run"
timeout /t 15

echo Starting User Service...
start "User Service" cmd /k "cd user-service && mvn spring-boot:run"
timeout /t 15

echo Starting Event Service...
start "Event Service" cmd /k "cd event-service && mvn spring-boot:run"
timeout /t 15

echo Starting Booking Service...
start "Booking Service" cmd /k "cd booking-service && mvn spring-boot:run"
timeout /t 15

echo Starting Payment Service...
start "Payment Service" cmd /k "cd payment-service && mvn spring-boot:run"
timeout /t 15

echo Starting Notification Service...
start "Notification Service" cmd /k "cd notification-service && mvn spring-boot:run"
timeout /t 15

echo Starting Review Service...
start "Review Service" cmd /k "cd review-service && mvn spring-boot:run"
timeout /t 15

echo Starting API Gateway...
start "API Gateway" cmd /k "cd api-gateway && mvn spring-boot:run"

echo.
echo All services started!
echo Wait 30 seconds for all services to be ready
echo Then access: http://localhost:4200
pause
