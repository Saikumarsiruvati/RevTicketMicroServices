@echo off
echo ========================================
echo Complete Data Migration from revtickets
echo ========================================
echo.

echo Step 1: Dumping all tables from revtickets database...
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets users > users_dump.sql
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets events > events_dump.sql
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets venues > venues_dump.sql
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets shows > shows_dump.sql
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets bookings > bookings_dump.sql
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets seats > seats_dump.sql
docker exec revticket-mysql mysqldump -uroot -p12345 --no-create-info revtickets payments > payments_dump.sql

echo.
echo Step 2: Importing data to microservices databases...

echo Importing users to user_db...
type users_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 user_db

echo Importing events to event_db...
type events_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 event_db

echo Importing venues to event_db...
type venues_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 event_db

echo Importing shows to event_db...
type shows_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 event_db

echo Importing bookings to booking_db...
type bookings_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 booking_db

echo Importing seats to booking_db...
type seats_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 booking_db

echo Importing payments to payment_db...
type payments_dump.sql | docker exec -i revticket-mysql mysql -uroot -p12345 payment_db

echo.
echo Step 3: Cleaning up dump files...
del users_dump.sql events_dump.sql venues_dump.sql shows_dump.sql bookings_dump.sql seats_dump.sql payments_dump.sql

echo.
echo ========================================
echo Migration Completed!
echo ========================================
echo.
echo Verifying data counts...
docker exec revticket-mysql mysql -uroot -p12345 -e "SELECT 'user_db.users' as Table_Name, COUNT(*) as Count FROM user_db.users UNION SELECT 'event_db.events', COUNT(*) FROM event_db.events UNION SELECT 'event_db.venues', COUNT(*) FROM event_db.venues UNION SELECT 'event_db.shows', COUNT(*) FROM event_db.shows UNION SELECT 'booking_db.bookings', COUNT(*) FROM booking_db.bookings UNION SELECT 'booking_db.seats', COUNT(*) FROM booking_db.seats UNION SELECT 'payment_db.payments', COUNT(*) FROM payment_db.payments;"

echo.
pause
