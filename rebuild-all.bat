@echo off
echo ========================================
echo Rebuilding All Microservices
echo ========================================

cd microservices-backend

echo.
echo [1/9] Building Auth Service...
cd auth-service
call mvn clean package -DskipTests
cd ..

echo.
echo [2/9] Building User Service...
cd user-service
call mvn clean package -DskipTests
cd ..

echo.
echo [3/9] Building Event Service...
cd event-service
call mvn clean package -DskipTests
cd ..

echo.
echo [4/9] Building Booking Service...
cd booking-service
call mvn clean package -DskipTests
cd ..

echo.
echo [5/9] Building Payment Service...
cd payment-service
call mvn clean package -DskipTests
cd ..

echo.
echo [6/9] Building Notification Service...
cd notification-service
call mvn clean package -DskipTests
cd ..

echo.
echo [7/9] Building Review Service...
cd review-service
call mvn clean package -DskipTests
cd ..

echo.
echo [8/9] Building Service Registry...
cd service-registry
call mvn clean package -DskipTests
cd ..

echo.
echo [9/9] Building API Gateway...
cd api-gateway
call mvn clean package -DskipTests
cd ..

cd ..

echo.
echo ========================================
echo All services built successfully!
echo ========================================
echo.
echo Press any key to start all services...
pause

call start-all-services.bat
