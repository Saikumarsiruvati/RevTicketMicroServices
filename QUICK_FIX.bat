@echo off
echo ========================================
echo REVTICKET - QUICK FIX SCRIPT
echo ========================================
echo.

cd microservices-backend

echo Step 1: Stopping all containers...
docker-compose down
echo.

echo Step 2: Removing any stuck containers...
docker rm -f revticket-mongo revticket-frontend api-gateway event-service booking-service payment-service notification-service review-service 2>nul
echo.

echo Step 3: Starting all services...
docker-compose up -d
echo.

echo Step 4: Waiting for services to start (60 seconds)...
timeout /t 60 /nobreak
echo.

echo Step 5: Checking service status...
docker ps --format "table {{.Names}}\t{{.Status}}"
echo.

echo ========================================
echo DONE! Now open: http://localhost:4200
echo ========================================
pause
