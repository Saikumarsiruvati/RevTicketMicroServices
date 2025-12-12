@echo off
echo ========================================
echo Exporting data from local revtickets database
echo ========================================

echo Exporting users...
mysqldump -uroot -p12345 --no-create-info revtickets users > users_data.sql

echo Exporting events, venues, shows...
mysqldump -uroot -p12345 --no-create-info revtickets events venues shows > events_data.sql

echo Exporting bookings, seats...
mysqldump -uroot -p12345 --no-create-info revtickets bookings seats > bookings_data.sql

echo Exporting payments...
mysqldump -uroot -p12345 --no-create-info revtickets payments > payments_data.sql

echo.
echo ========================================
echo Importing data to Docker MySQL
echo ========================================

echo Importing users to user_db...
type users_data.sql | docker exec -i revticket-mysql mysql -uroot -p12345 user_db

echo Importing events to event_db...
type events_data.sql | docker exec -i revticket-mysql mysql -uroot -p12345 event_db

echo Importing bookings to booking_db...
type bookings_data.sql | docker exec -i revticket-mysql mysql -uroot -p12345 booking_db

echo Importing payments to payment_db...
type payments_data.sql | docker exec -i revticket-mysql mysql -uroot -p12345 payment_db

echo.
echo ========================================
echo Data migration completed!
echo ========================================

del users_data.sql events_data.sql bookings_data.sql payments_data.sql
