@echo off
echo Starting missing microservices...

echo Starting Booking Service (Port 8083)...
start "Booking Service" cmd /k "cd microservices-backend\booking-service && mvn spring-boot:run"

timeout /t 5

echo Starting Payment Service (Port 8084)...
start "Payment Service" cmd /k "cd microservices-backend\payment-service && mvn spring-boot:run"

timeout /t 5

echo Starting Notification Service (Port 8085)...
start "Notification Service" cmd /k "cd microservices-backend\notification-service && mvn spring-boot:run"

timeout /t 5

echo Starting Review Service (Port 8087)...
start "Review Service" cmd /k "cd microservices-backend\review-service && mvn spring-boot:run"

echo All missing services are starting...
echo Wait 2-3 minutes for all services to fully start
pause