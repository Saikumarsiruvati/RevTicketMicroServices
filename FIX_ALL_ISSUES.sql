-- Fix all database issues
USE event_db;

-- Delete invalid shows
DELETE FROM shows WHERE show_time IS NULL OR show_time = '0000-00-00 00:00:00';

-- Update events category to lowercase
UPDATE events SET category = LOWER(category);

USE user_db;

-- Ensure admin user exists with correct password (admin123)
DELETE FROM users WHERE email = 'admin@revtickets.com';
INSERT INTO users (name, email, password, phone, role, is_blocked) VALUES
('Admin', 'admin@revtickets.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '9999999999', 'ADMIN', false);
