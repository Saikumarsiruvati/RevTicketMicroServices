@echo off
echo ========================================
echo Final Data Migration - Connecting to Local MySQL
echo ========================================
echo.

echo Checking if mysqldump is available...
where mysqldump >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: mysqldump not found in PATH
    echo Please add MySQL bin directory to PATH or run from MySQL bin folder
    echo Example: C:\Program Files\MySQL\MySQL Server 8.0\bin
    pause
    exit /b 1
)

echo.
echo Step 1: Exporting from LOCAL MySQL (localhost:3306)...
mysqldump -uroot -p12345 -h 127.0.0.1 --port=3306 --no-create-info --skip-triggers revtickets venues 2>nul > venues_dump.sql
mysqldump -uroot -p12345 -h 127.0.0.1 --port=3306 --no-create-info --skip-triggers revtickets shows 2>nul > shows_dump.sql
mysqldump -uroot -p12345 -h 127.0.0.1 --port=3306 --no-create-info --skip-triggers revtickets bookings 2>nul > bookings_dump.sql
mysqldump -uroot -p12345 -h 127.0.0.1 --port=3306 --no-create-info --skip-triggers revtickets seats 2>nul > seats_dump.sql
mysqldump -uroot -p12345 -h 127.0.0.1 --port=3306 --no-create-info --skip-triggers revtickets payments 2>nul > payments_dump.sql

echo.
echo Step 2: Importing to DOCKER MySQL (localhost:3307)...
type venues_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 event_db 2>nul
type shows_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 event_db 2>nul
type bookings_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 booking_db 2>nul
type seats_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 booking_db 2>nul
type payments_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 payment_db 2>nul

echo.
echo Step 3: Cleaning up...
del venues_dump.sql shows_dump.sql bookings_dump.sql seats_dump.sql payments_dump.sql 2>nul

echo.
echo ========================================
echo Migration Completed!
echo ========================================
echo.
echo Verifying data counts...
docker exec revticket-mysql mysql -uroot -p12345 -e "SELECT 'user_db.users' as Table_Name, COUNT(*) as Count FROM user_db.users UNION SELECT 'event_db.events', COUNT(*) FROM event_db.events UNION SELECT 'event_db.venues', COUNT(*) FROM event_db.venues UNION SELECT 'event_db.shows', COUNT(*) FROM event_db.shows UNION SELECT 'booking_db.bookings', COUNT(*) FROM booking_db.bookings UNION SELECT 'booking_db.seats', COUNT(*) FROM booking_db.seats UNION SELECT 'payment_db.payments', COUNT(*) FROM payment_db.payments;" 2>nul

echo.
echo If you see 0 counts above, mysqldump might not be in PATH
echo Add MySQL bin folder to PATH: C:\Program Files\MySQL\MySQL Server 8.0\bin
echo.
pause
