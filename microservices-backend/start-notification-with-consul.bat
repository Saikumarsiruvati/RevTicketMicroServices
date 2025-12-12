@echo off
echo Starting Consul in background...
start "Consul" consul agent -dev

timeout /t 5 /nobreak >nul

echo Starting Notification Service...
cd notification-service
mvn spring-boot:run
