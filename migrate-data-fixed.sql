-- First, let the services create the tables by starting them
-- Then run this script to copy data

-- Migrate users
INSERT INTO user_db.users (id, name, email, password, phone, role, is_blocked, created_at, updated_at)
SELECT id, name, email, password, phone, role, is_blocked, created_at, updated_at FROM revtickets.users;

-- Migrate events
INSERT INTO event_db.events (id, title, category, language, genre_or_type, description, city, venue, date_time, duration_minutes, poster_url, rating, price, is_active)
SELECT id, title, category, language, genre_or_type, description, city, venue, date_time, duration_minutes, poster_url, rating, price, is_active FROM revtickets.events;

-- Migrate venues (if exists)
INSERT INTO event_db.venues SELECT * FROM revtickets.venues WHERE EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema='revtickets' AND table_name='venues');

-- Migrate shows
INSERT INTO event_db.shows (id, event_id, venue_id, show_time, available_seats, is_active)
SELECT id, event_id, venue_id, show_time, available_seats, is_active FROM revtickets.shows;

-- Migrate bookings
INSERT INTO booking_db.bookings (id, user_id, show_id, number_of_seats, seat_numbers, total_amount, status, booking_date)
SELECT id, user_id, show_id, number_of_seats, seat_numbers, total_amount, status, booking_date FROM revtickets.bookings;

-- Migrate seats
INSERT INTO booking_db.seats (id, show_id, seat_number, seat_type, price, is_booked, booking_id)
SELECT id, show_id, seat_number, seat_type, price, is_booked, booking_id FROM revtickets.seats;

-- Migrate payments (if exists)
INSERT INTO payment_db.payments SELECT * FROM revtickets.payments WHERE EXISTS (SELECT 1 FROM information_schema.tables WHERE table_schema='revtickets' AND table_name='payments');
