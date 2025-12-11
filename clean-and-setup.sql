-- Clean and setup databases
USE user_db;
DROP TABLE IF EXISTS users;

USE event_db;
DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS events;
DROP TABLE IF EXISTS venues;

USE revtickets;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS seats;
DROP TABLE IF EXISTS bookings;
