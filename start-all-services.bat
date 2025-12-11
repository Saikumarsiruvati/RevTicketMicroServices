@echo off
echo Starting all RevTicket Microservices...
echo.

cd /d "%~dp0microservices-backend"

start "Service Registry" cmd /k "cd service-registry && mvn spring-boot:run"
timeout /t 15 /nobreak

start "Auth Service" cmd /k "cd auth-service && mvn spring-boot:run"
start "User Service" cmd /k "cd user-service && mvn spring-boot:run"
start "Event Service" cmd /k "cd event-service && mvn spring-boot:run"
start "Booking Service" cmd /k "cd booking-service && mvn spring-boot:run"
start "Payment Service" cmd /k "cd payment-service && mvn spring-boot:run"
start "Notification Service" cmd /k "cd notification-service && mvn spring-boot:run"
start "Review Service" cmd /k "cd review-service && mvn spring-boot:run"

echo.
echo All services are starting...
echo Service Registry will start first, then other services after 15 seconds.
echo.
echo Services:
echo - Service Registry: http://localhost:8761
echo - Auth Service: http://localhost:8086
echo - User Service: http://localhost:8081
echo - Event Service: http://localhost:8082
echo - Booking Service: http://localhost:8083
echo - Payment Service: http://localhost:8084
echo - Notification Service: http://localhost:8085
echo - Review Service: http://localhost:8087
echo - API Gateway: http://localhost:8080 (already running)
echo.
echo Wait 1-2 minutes for all services to fully start.
pause
