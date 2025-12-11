-- Create separate databases for each microservice
CREATE DATABASE IF NOT EXISTS user_db;
CREATE DATABASE IF NOT EXISTS event_db;
CREATE DATABASE IF NOT EXISTS booking_db;
CREATE DATABASE IF NOT EXISTS payment_db;

-- Copy users table to user_db
CREATE TABLE user_db.users LIKE revtickets.users;
INSERT INTO user_db.users SELECT * FROM revtickets.users;

-- Copy events, venues, shows to event_db
CREATE TABLE event_db.events LIKE revtickets.events;
INSERT INTO event_db.events SELECT * FROM revtickets.events;

CREATE TABLE event_db.venues LIKE revtickets.venues;
INSERT INTO event_db.venues SELECT * FROM revtickets.venues;

CREATE TABLE event_db.shows LIKE revtickets.shows;
INSERT INTO event_db.shows SELECT * FROM revtickets.shows;

-- Copy bookings, seats to booking_db
CREATE TABLE booking_db.bookings LIKE revtickets.bookings;
INSERT INTO booking_db.bookings SELECT * FROM revtickets.bookings;

CREATE TABLE booking_db.seats LIKE revtickets.seats;
INSERT INTO booking_db.seats SELECT * FROM revtickets.seats;

-- Copy payments to payment_db
CREATE TABLE payment_db.payments LIKE revtickets.payments;
INSERT INTO payment_db.payments SELECT * FROM revtickets.payments;
