@echo off
echo ========================================
echo Testing RevTicket API Endpoints
echo ========================================
echo.

echo Testing API Gateway...
curl -s http://localhost:8080/actuator/health
echo.

echo Testing Auth Service...
curl -s http://localhost:8086/actuator/health
echo.

echo Testing User Service...
curl -s http://localhost:8081/actuator/health
echo.

echo Testing Event Service...
curl -s http://localhost:8082/actuator/health
echo.

echo Testing Booking Service...
curl -s http://localhost:8083/actuator/health
echo.

echo Testing Payment Service...
curl -s http://localhost:8084/actuator/health
echo.

echo Testing Notification Service...
curl -s http://localhost:8085/actuator/health
echo.

echo Testing Review Service...
curl -s http://localhost:8087/actuator/health
echo.

echo.
echo ========================================
echo Testing API Endpoints via Gateway
echo ========================================
echo.

echo Testing GET /api/events...
curl -s http://localhost:8080/api/events
echo.
echo.

echo Testing GET /api/shows...
curl -s http://localhost:8080/api/shows
echo.
echo.

echo Testing GET /api/venues...
curl -s http://localhost:8080/api/venues
echo.
echo.

echo.
echo ========================================
echo All tests complete!
echo ========================================
pause
