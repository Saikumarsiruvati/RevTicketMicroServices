@echo off
echo Starting Consul...

cd /d "%~dp0"

if not exist "consul.exe" (
    echo Consul not found. Please download it from: https://www.consul.io/downloads
    echo.
    echo Download consul_1.17.0_windows_amd64.zip
    echo Extract consul.exe to: %~dp0
    echo Then run this script again.
    pause
    exit /b
)

start "Consul" cmd /k "consul agent -dev -ui -client=0.0.0.0"

echo.
echo Consul is starting...
echo Consul UI: http://localhost:8500
echo.
pause
