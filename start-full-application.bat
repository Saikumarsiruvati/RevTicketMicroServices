@echo off
echo Starting Full RevTicket Application...
echo.

echo Starting Backend Microservices...
start "Backend Services" cmd /k "cd microservices-backend && start-all-services.bat"
timeout /t 30

echo Starting Frontend...
start "Frontend" cmd /k "cd monolithic-frontend && start-frontend.bat"

echo.
echo Full application is starting...
echo Backend API Gateway: http://localhost:8080
echo Frontend: http://localhost:4200
echo Service Registry: http://localhost:8761
echo.
pause
