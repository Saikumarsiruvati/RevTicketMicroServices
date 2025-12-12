-- Migrate data from revtickets database to microservices databases

-- Create databases if not exist
CREATE DATABASE IF NOT EXISTS user_db;
CREATE DATABASE IF NOT EXISTS event_db;
CREATE DATABASE IF NOT EXISTS booking_db;
CREATE DATABASE IF NOT EXISTS payment_db;

-- Migrate Users data
INSERT INTO user_db.users SELECT * FROM revtickets.users WHERE NOT EXISTS (SELECT 1 FROM user_db.users);

-- Migrate Events, Venues, Shows data
INSERT INTO event_db.events SELECT * FROM revtickets.events WHERE NOT EXISTS (SELECT 1 FROM event_db.events);
INSERT INTO event_db.venues SELECT * FROM revtickets.venues WHERE NOT EXISTS (SELECT 1 FROM event_db.venues);
INSERT INTO event_db.shows SELECT * FROM revtickets.shows WHERE NOT EXISTS (SELECT 1 FROM event_db.shows);

-- Migrate Bookings and Seats data
INSERT INTO booking_db.bookings SELECT * FROM revtickets.bookings WHERE NOT EXISTS (SELECT 1 FROM booking_db.bookings);
INSERT INTO booking_db.seats SELECT * FROM revtickets.seats WHERE NOT EXISTS (SELECT 1 FROM booking_db.seats);

-- Migrate Payments data
INSERT INTO payment_db.payments SELECT * FROM revtickets.payments WHERE NOT EXISTS (SELECT 1 FROM payment_db.payments);
