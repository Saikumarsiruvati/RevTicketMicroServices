@echo off
echo Stopping API Gateway on port 8080...
for /f "tokens=5" %%a in ('netstat -aon ^| find ":8080" ^| find "LISTENING"') do taskkill /F /PID %%a 2>nul
timeout /t 3 /nobreak >nul

echo Starting API Gateway...
cd microservices-backend\api-gateway
start "API Gateway" cmd /k "mvn spring-boot:run"

echo API Gateway restart initiated!
