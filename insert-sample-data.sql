-- Insert sample events
USE event_db;

INSERT INTO events (title, category, language, genre_or_type, description, city, venue, duration_minutes, poster_url, rating, price, is_active) VALUES
('Avengers: Endgame', 'MOVIES', 'English', 'Action', 'Epic superhero movie', 'Mumbai', 'PVR Cinemas', 180, 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400', 4.5, 300, true),
('KGF Chapter 2', 'MOVIES', 'Hindi', 'Action', 'Action packed thriller', 'Bangalore', 'INOX', 168, 'https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=400', 4.3, 250, true),
('RRR', 'MOVIES', 'Telugu', 'Action', 'Period action drama', 'Hyderabad', 'AMB Cinemas', 187, 'https://images.unsplash.com/photo-1574267432644-f610f5b7e4d1?w=400', 4.7, 280, true);

-- Insert sample venues
INSERT INTO venues (name, city, address, total_seats, type, is_active) VALUES
('PVR Cinemas', 'Mumbai', 'Phoenix Mall, Lower Parel', 300, 'CINEMA', true),
('INOX', 'Bangalore', 'Garuda Mall, Magrath Road', 250, 'CINEMA', true),
('AMB Cinemas', 'Hyderabad', 'Gachibowli', 400, 'CINEMA', true);

-- Insert sample shows
INSERT INTO shows (event_id, venue_id, show_time, available_seats, is_active) VALUES
(1, 1, '2025-12-15 18:00:00', 300, true),
(1, 1, '2025-12-15 21:00:00', 300, true),
(2, 2, '2025-12-16 19:00:00', 250, true),
(3, 3, '2025-12-17 20:00:00', 400, true);

-- Insert admin user
USE user_db;

INSERT INTO users (name, email, password, phone, role, is_blocked) VALUES
('Admin', 'admin@revtickets.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '9999999999', 'ADMIN', false),
('Test User', 'user@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '8888888888', 'USER', false);
