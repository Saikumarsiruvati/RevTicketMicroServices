@echo off
echo Waiting for services to create tables...
timeout /t 30 /nobreak

echo Copying data from local MySQL to Docker MySQL...
echo This requires MySQL client installed locally

echo.
echo MANUAL STEPS:
echo 1. Open MySQL Workbench or command line
echo 2. Connect to LOCAL MySQL (localhost:3306)
echo 3. Export revtickets database tables
echo 4. Connect to DOCKER MySQL (localhost:3307)
echo 5. Import data to respective databases:
echo    - users -> user_db
echo    - events, venues, shows -> event_db
echo    - bookings, seats -> booking_db
echo    - payments -> payment_db
echo.
echo OR use the application to recreate data (recommended for testing)
pause
