@echo off
echo Migrating data from revtickets database (localhost:3306) to microservices databases (Docker:3307)
echo.

echo Step 1: Exporting revtickets database...
"C:\Program Files\MySQL\MySQL Server 8.0\bin\mysqldump" -uroot -p12345 -h localhost -P 3306 revtickets > revtickets_backup.sql 2>nul
if errorlevel 1 (
    echo MySQL not found at default location. Trying alternative path...
    "C:\Program Files\MySQL\MySQL Server 9.0\bin\mysqldump" -uroot -p12345 -h localhost -P 3306 revtickets > revtickets_backup.sql 2>nul
)
if errorlevel 1 (
    echo ERROR: Could not find mysqldump. Please run manually:
    echo mysqldump -uroot -p12345 -h localhost -P 3306 revtickets ^> revtickets_backup.sql
    pause
    exit /b 1
)

echo Step 2: Copying data to Docker MySQL...
docker exec -i revticket-mysql mysql -uroot -p12345 < revtickets_backup.sql

echo.
echo Step 3: Migrating data to microservices databases...
docker exec revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO user_db.users SELECT * FROM revtickets.users; INSERT IGNORE INTO event_db.events SELECT * FROM revtickets.events; INSERT IGNORE INTO event_db.venues SELECT * FROM revtickets.venues; INSERT IGNORE INTO event_db.shows SELECT * FROM revtickets.shows; INSERT IGNORE INTO booking_db.bookings SELECT * FROM revtickets.bookings WHERE 1=1; INSERT IGNORE INTO booking_db.seats SELECT * FROM revtickets.seats WHERE 1=1; INSERT IGNORE INTO payment_db.payments SELECT * FROM revtickets.payments WHERE 1=1;"

echo.
echo Migration complete!
echo Restarting services...
docker-compose restart user-service event-service booking-service payment-service

echo.
echo Done! Data migrated from revtickets to microservices databases.
pause
