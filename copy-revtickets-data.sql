-- Run this script on your LOCAL MySQL (port 3306) to export data from revtickets database
-- Then the data will be copied to Docker MySQL (port 3307)

-- Step 1: Export from revtickets database on localhost:3306
-- Run this command in your terminal:
-- mysqldump -uroot -p12345 -h localhost -P 3306 revtickets > revtickets_backup.sql

-- Step 2: Import to Docker MySQL
-- Then run: docker exec -i revticket-mysql mysql -uroot -p12345 < revtickets_backup.sql

-- OR if you want to copy specific tables:

-- For users table:
-- INSERT INTO user_db.users SELECT * FROM revtickets.users;

-- For events table:
-- INSERT INTO event_db.events SELECT * FROM revtickets.events;

-- For venues table:
-- INSERT INTO event_db.venues SELECT * FROM revtickets.venues;

-- For shows table:
-- INSERT INTO event_db.shows SELECT * FROM revtickets.shows;

-- For bookings table:
-- INSERT INTO booking_db.bookings SELECT * FROM revtickets.bookings;

-- For payments table:
-- INSERT INTO payment_db.payments SELECT * FROM revtickets.payments;
