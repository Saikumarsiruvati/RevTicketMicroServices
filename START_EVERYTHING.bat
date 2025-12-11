@echo off
echo Starting ALL Services...
cd microservices-backend

start "Service Registry" cmd /k "cd service-registry && mvn spring-boot:run"
timeout /t 20

start "Auth Service" cmd /k "cd auth-service && mvn spring-boot:run"
timeout /t 10

start "User Service" cmd /k "cd user-service && mvn spring-boot:run"
timeout /t 10

start "Event Service" cmd /k "cd event-service && mvn spring-boot:run"
timeout /t 10

start "Booking Service" cmd /k "cd booking-service && mvn spring-boot:run"
timeout /t 10

start "Payment Service" cmd /k "cd payment-service && mvn spring-boot:run"
timeout /t 10

start "Notification Service" cmd /k "cd notification-service && mvn spring-boot:run"
timeout /t 10

start "Review Service" cmd /k "cd review-service && mvn spring-boot:run"
timeout /t 10

start "API Gateway" cmd /k "cd api-gateway && mvn spring-boot:run"

cd ..\monolithic-frontend
timeout /t 20
start "Frontend" cmd /k "npm start"

echo All services started!
echo Wait 2 minutes then open: http://localhost:4200
pause
