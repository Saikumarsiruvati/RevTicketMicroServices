@echo off
echo ========================================
echo Migrating data from revtickets to microservices databases
echo ========================================
echo.

echo Creating microservices databases...
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE DATABASE IF NOT EXISTS user_db;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE DATABASE IF NOT EXISTS event_db;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE DATABASE IF NOT EXISTS booking_db;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE DATABASE IF NOT EXISTS payment_db;"

echo.
echo Copying users table...
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS user_db.users LIKE revtickets.users;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO user_db.users SELECT * FROM revtickets.users;"

echo Copying events, venues, shows tables...
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS event_db.events LIKE revtickets.events;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO event_db.events SELECT * FROM revtickets.events;"

docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS event_db.venues LIKE revtickets.venues;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO event_db.venues SELECT * FROM revtickets.venues;"

docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS event_db.shows LIKE revtickets.shows;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO event_db.shows SELECT * FROM revtickets.shows;"

echo Copying bookings and seats tables...
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS booking_db.bookings LIKE revtickets.bookings;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO booking_db.bookings SELECT * FROM revtickets.bookings;"

docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS booking_db.seats LIKE revtickets.seats;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO booking_db.seats SELECT * FROM revtickets.seats;"

echo Copying payments table...
docker exec -i revticket-mysql mysql -uroot -p12345 -e "CREATE TABLE IF NOT EXISTS payment_db.payments LIKE revtickets.payments;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "INSERT IGNORE INTO payment_db.payments SELECT * FROM revtickets.payments;"

echo.
echo ========================================
echo Data migration completed!
echo ========================================
echo.
echo Verifying data...
docker exec -i revticket-mysql mysql -uroot -p12345 -e "SELECT COUNT(*) as user_count FROM user_db.users;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "SELECT COUNT(*) as event_count FROM event_db.events;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "SELECT COUNT(*) as booking_count FROM booking_db.bookings;"
docker exec -i revticket-mysql mysql -uroot -p12345 -e "SELECT COUNT(*) as payment_count FROM payment_db.payments;"
