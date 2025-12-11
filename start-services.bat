@echo off
echo Starting RevTicket Microservices...

cd microservices-backend\user-service
start "User Service" cmd /k "mvn spring-boot:run"
timeout /t 15

cd ..\auth-service
start "Auth Service" cmd /k "mvn spring-boot:run"
timeout /t 10

cd ..\api-gateway
start "API Gateway" cmd /k "mvn spring-boot:run"
timeout /t 10

cd ..\..\monolithic-frontend
start "Frontend" cmd /k "npm start"

echo All services started!
