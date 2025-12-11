-- Complete data migration from revtickets to microservices databases
-- Run this after all microservices have started and created their tables

-- Clear existing data in microservices databases (optional)
-- DELETE FROM user_db.users;
-- DELETE FROM event_db.events;
-- DELETE FROM event_db.venues;
-- DELETE FROM event_db.shows;
-- DELETE FROM booking_db.bookings;
-- DELETE FROM booking_db.seats;
-- DELETE FROM payment_db.payments;

-- Migrate users to user_db
INSERT IGNORE INTO user_db.users (id, name, email, password, phone, role, is_blocked, created_at, updated_at)
SELECT id, name, email, password, phone, role, is_blocked, created_at, updated_at 
FROM revtickets.users;

-- Migrate events to event_db
INSERT IGNORE INTO event_db.events (id, title, category, language, genre_or_type, description, city, venue, date_time, duration_minutes, poster_url, rating, price, is_active)
SELECT id, title, category, language, genre_or_type, description, city, venue, date_time, duration_minutes, poster_url, rating, price, is_active 
FROM revtickets.events;

-- Migrate venues to event_db (if table exists)
INSERT IGNORE INTO event_db.venues 
SELECT * FROM revtickets.venues 
WHERE EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema='revtickets' AND table_name='venues');

-- Migrate shows to event_db
INSERT IGNORE INTO event_db.shows (id, event_id, venue_id, show_time, available_seats, is_active)
SELECT id, event_id, venue_id, show_time, available_seats, is_active 
FROM revtickets.shows;

-- Migrate bookings to booking_db
INSERT IGNORE INTO booking_db.bookings (id, user_id, show_id, number_of_seats, seat_numbers, total_amount, status, booking_date)
SELECT id, user_id, show_id, number_of_seats, seat_numbers, total_amount, status, booking_date 
FROM revtickets.bookings;

-- Migrate seats to booking_db
INSERT IGNORE INTO booking_db.seats (id, show_id, seat_number, seat_type, price, is_booked, booking_id)
SELECT id, show_id, seat_number, seat_type, price, is_booked, booking_id 
FROM revtickets.seats;

-- Migrate payments to payment_db (if table exists)
INSERT IGNORE INTO payment_db.payments 
SELECT * FROM revtickets.payments 
WHERE EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema='revtickets' AND table_name='payments');

-- Show migration results
SELECT 'Users migrated:' as info, COUNT(*) as count FROM user_db.users
UNION ALL
SELECT 'Events migrated:', COUNT(*) FROM event_db.events
UNION ALL
SELECT 'Shows migrated:', COUNT(*) FROM event_db.shows
UNION ALL
SELECT 'Bookings migrated:', COUNT(*) FROM booking_db.bookings
UNION ALL
SELECT 'Seats migrated:', COUNT(*) FROM booking_db.seats;