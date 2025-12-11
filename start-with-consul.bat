@echo off
echo Starting Consul...
docker-compose -f docker-compose-consul.yml up -d
timeout /t 5 /nobreak

echo Starting all microservices...
cd microservices-backend

start "User Service" cmd /c "cd user-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "Auth Service" cmd /c "cd auth-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "Event Service" cmd /c "cd event-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "Booking Service" cmd /c "cd booking-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "Payment Service" cmd /c "cd payment-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "Notification Service" cmd /c "cd notification-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "Review Service" cmd /c "cd review-service && mvn spring-boot:run"
timeout /t 3 /nobreak

start "API Gateway" cmd /c "cd api-gateway && mvn spring-boot:run"

echo All services starting...
echo Consul UI: http://localhost:8500
echo API Gateway: http://localhost:8080
