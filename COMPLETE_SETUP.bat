@echo off
echo ========================================
echo RevTicket Complete Setup
echo ========================================

echo Step 1: Inserting sample data...
mysql -u root -p12345 < insert-sample-data.sql
echo Sample data inserted!

echo.
echo Step 2: Killing existing services...
taskkill /F /IM java.exe 2>nul
timeout /t 3

echo.
echo Step 3: Starting all services...
cd microservices-backend

start "Service Registry" cmd /k "cd service-registry && mvn spring-boot:run"
timeout /t 20

start "Auth Service" cmd /k "cd auth-service && mvn spring-boot:run"
timeout /t 15

start "User Service" cmd /k "cd user-service && mvn spring-boot:run"
timeout /t 15

start "Event Service" cmd /k "cd event-service && mvn spring-boot:run"
timeout /t 15

start "Booking Service" cmd /k "cd booking-service && mvn spring-boot:run"
timeout /t 15

start "Payment Service" cmd /k "cd payment-service && mvn spring-boot:run"
timeout /t 15

start "Notification Service" cmd /k "cd notification-service && mvn spring-boot:run"
timeout /t 15

start "Review Service" cmd /k "cd review-service && mvn spring-boot:run"
timeout /t 15

start "API Gateway" cmd /k "cd api-gateway && mvn spring-boot:run"

echo.
echo ========================================
echo Setup Complete!
echo ========================================
echo.
echo Services starting... Wait 30 seconds
echo Then access: http://localhost:4200
echo Login: admin@revtickets.com / admin123
echo.
pause
