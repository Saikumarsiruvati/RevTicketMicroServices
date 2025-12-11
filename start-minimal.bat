@echo off
cd microservices-backend\user-service
start "User Service" cmd /k "mvn spring-boot:run"
timeout /t 20

cd ..\auth-service
start "Auth Service" cmd /k "mvn spring-boot:run"
timeout /t 15

cd ..\api-gateway
start "API Gateway" cmd /k "mvn spring-boot:run"
