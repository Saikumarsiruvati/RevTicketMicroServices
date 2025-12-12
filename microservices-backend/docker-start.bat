@echo off
echo ========================================
echo Building and Starting RevTicket Microservices
echo ========================================
echo.

echo Step 1: Stopping any existing containers...
docker-compose down

echo.
echo Step 2: Building Docker images...
docker-compose build

echo.
echo Step 3: Starting all services...
docker-compose up -d

echo.
echo ========================================
echo Services are starting...
echo ========================================
echo.
echo Access Points:
echo - API Gateway: http://localhost:8080
echo - Consul UI: http://localhost:8500
echo - MySQL: localhost:3306
echo - MongoDB: localhost:27017
echo.
echo To view logs: docker-compose logs -f [service-name]
echo To stop all: docker-compose down
echo ========================================
