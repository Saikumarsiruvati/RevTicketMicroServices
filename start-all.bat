@echo off
cd microservices-backend
start "API-Gateway" cmd /k "cd api-gateway && mvn spring-boot:run"
timeout /t 20
start "User-Service" cmd /k "cd user-service && mvn spring-boot:run"
timeout /t 20
start "Auth-Service" cmd /k "cd auth-service && mvn spring-boot:run"
timeout /t 20
start "Event-Service" cmd /k "cd event-service && mvn spring-boot:run"
timeout /t 15
start "Booking-Service" cmd /k "cd booking-service && mvn spring-boot:run"
timeout /t 15
start "Payment-Service" cmd /k "cd payment-service && mvn spring-boot:run"
echo All services started!
