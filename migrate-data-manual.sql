-- Manual migration script
-- Run this inside Docker MySQL after importing revtickets database

-- Copy users from revtickets to user_db
INSERT IGNORE INTO user_db.users 
SELECT * FROM revtickets.users;

-- Copy events from revtickets to event_db
INSERT IGNORE INTO event_db.events 
SELECT * FROM revtickets.events;

-- Copy venues from revtickets to event_db
INSERT IGNORE INTO event_db.venues 
SELECT * FROM revtickets.venues;

-- Copy shows from revtickets to event_db
INSERT IGNORE INTO event_db.shows 
SELECT * FROM revtickets.shows;

-- Copy bookings from revtickets to booking_db (if exists)
INSERT IGNORE INTO booking_db.bookings 
SELECT * FROM revtickets.bookings 
WHERE EXISTS (SELECT 1 FROM revtickets.bookings LIMIT 1);

-- Copy seats from revtickets to booking_db (if exists)
INSERT IGNORE INTO booking_db.seats 
SELECT * FROM revtickets.seats 
WHERE EXISTS (SELECT 1 FROM revtickets.seats LIMIT 1);

-- Copy payments from revtickets to payment_db (if exists)
INSERT IGNORE INTO payment_db.payments 
SELECT * FROM revtickets.payments 
WHERE EXISTS (SELECT 1 FROM revtickets.payments LIMIT 1);
