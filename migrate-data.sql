-- Migrate users table to user_db
INSERT INTO user_db.users SELECT * FROM revtickets.users;

-- Migrate events, venues, shows to event_db
INSERT INTO event_db.events SELECT * FROM revtickets.events;
INSERT INTO event_db.venues SELECT * FROM revtickets.venues;
INSERT INTO event_db.shows SELECT * FROM revtickets.shows;

-- Migrate bookings and seats to booking_db
INSERT INTO booking_db.bookings SELECT * FROM revtickets.bookings;
INSERT INTO booking_db.seats SELECT * FROM revtickets.seats;

-- Migrate payments to payment_db
INSERT INTO payment_db.payments SELECT * FROM revtickets.payments;
