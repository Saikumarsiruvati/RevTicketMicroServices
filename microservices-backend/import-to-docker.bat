@echo off
echo ========================================
echo Importing data to Docker MySQL
echo ========================================
echo.
echo Step 1: Waiting for services to create tables (30 seconds)...
timeout /t 30 /nobreak >nul

echo.
echo Step 2: Copying data files to Docker container...
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\users.csv revticket-mysql:/tmp/
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\events.csv revticket-mysql:/tmp/
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\venues.csv revticket-mysql:/tmp/
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\shows.csv revticket-mysql:/tmp/
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\bookings.csv revticket-mysql:/tmp/
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\seats.csv revticket-mysql:/tmp/
docker cp C:\ProgramData\MySQL\MySQL Server 8.0\Uploads\payments.csv revticket-mysql:/tmp/

echo.
echo Step 3: Importing data into microservices databases...

echo Importing users...
docker exec revticket-mysql mysql -uroot -p12345 user_db -e "LOAD DATA INFILE '/tmp/users.csv' INTO TABLE users FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo Importing events...
docker exec revticket-mysql mysql -uroot -p12345 event_db -e "LOAD DATA INFILE '/tmp/events.csv' INTO TABLE events FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo Importing venues...
docker exec revticket-mysql mysql -uroot -p12345 event_db -e "LOAD DATA INFILE '/tmp/venues.csv' INTO TABLE venues FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo Importing shows...
docker exec revticket-mysql mysql -uroot -p12345 event_db -e "LOAD DATA INFILE '/tmp/shows.csv' INTO TABLE shows FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo Importing bookings...
docker exec revticket-mysql mysql -uroot -p12345 booking_db -e "LOAD DATA INFILE '/tmp/bookings.csv' INTO TABLE bookings FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo Importing seats...
docker exec revticket-mysql mysql -uroot -p12345 booking_db -e "LOAD DATA INFILE '/tmp/seats.csv' INTO TABLE seats FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo Importing payments...
docker exec revticket-mysql mysql -uroot -p12345 payment_db -e "LOAD DATA INFILE '/tmp/payments.csv' INTO TABLE payments FIELDS TERMINATED BY ',' ENCLOSED BY '\"' LINES TERMINATED BY '\n';"

echo.
echo ========================================
echo Data import completed!
echo ========================================
echo.
echo Verifying data counts...
docker exec revticket-mysql mysql -uroot -p12345 -e "SELECT 'Users:' as Table_Name, COUNT(*) as Count FROM user_db.users UNION SELECT 'Events:', COUNT(*) FROM event_db.events UNION SELECT 'Venues:', COUNT(*) FROM event_db.venues UNION SELECT 'Bookings:', COUNT(*) FROM booking_db.bookings;"
