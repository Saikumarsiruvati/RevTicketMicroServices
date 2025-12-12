CREATE DATABASE IF NOT EXISTS user_db;
CREATE DATABASE IF NOT EXISTS event_db;
CREATE DATABASE IF NOT EXISTS booking_db;
CREATE DATABASE IF NOT EXISTS payment_db;

USE user_db;
CREATE TABLE IF NOT EXISTS users (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    phone VARCHAR(255),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    role ENUM('USER', 'ADMIN') DEFAULT 'USER',
    is_blocked TINYINT(1) DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME(6)
);

INSERT INTO users (name, email, password, phone, first_name, last_name, role, is_blocked) VALUES
('Admin', 'admin@revtickets.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '9999999999', 'Admin', 'User', 'ADMIN', FALSE),
('Test User', 'user@test.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '8888888888', 'Test', 'User', 'USER', FALSE),
('John Doe', 'john@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '7777777777', 'John', 'Doe', 'USER', FALSE);

USE event_db;
CREATE TABLE IF NOT EXISTS venues (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    location VARCHAR(255),
    total_seats INT,
    capacity INT,
    type VARCHAR(255),
    is_active BIT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS events (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    category VARCHAR(100),
    language VARCHAR(50),
    genre_or_type VARCHAR(100),
    description TEXT,
    city VARCHAR(100),
    venue VARCHAR(255),
    date_time DATETIME,
    duration_minutes INT,
    poster_url VARCHAR(500),
    rating DOUBLE,
    price DOUBLE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS shows (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    event_id BIGINT NOT NULL,
    venue_id BIGINT NOT NULL,
    show_date DATE NOT NULL,
    show_time DATETIME(6),
    available_seats INT,
    price DECIMAL(10,2),
    is_active BIT(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (event_id) REFERENCES events(id),
    FOREIGN KEY (venue_id) REFERENCES venues(id)
);

INSERT INTO venues (name, city, address, total_seats, type, is_active) VALUES
('PVR Cinemas', 'Mumbai', 'Phoenix Mall, Lower Parel', 300, 'CINEMA', true),
('INOX', 'Bangalore', 'Garuda Mall, Magrath Road', 250, 'CINEMA', true),
('AMB Cinemas', 'Hyderabad', 'Gachibowli', 400, 'CINEMA', true),
('Wankhede Stadium', 'Mumbai', 'D Road, Churchgate', 33000, 'STADIUM', true),
('M Chinnaswamy Stadium', 'Bangalore', 'MG Road', 40000, 'STADIUM', true);

INSERT INTO events (title, category, language, genre_or_type, description, city, venue, date_time, duration_minutes, poster_url, rating, price, is_active) VALUES
('Avengers: Endgame', 'MOVIES', 'English', 'Action', 'Epic superhero movie - The final battle', 'Mumbai', 'PVR Cinemas', '2025-12-15 18:00:00', 180, 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?w=400', 4.5, 300, true),
('KGF Chapter 2', 'MOVIES', 'Hindi', 'Action', 'Action packed thriller with mass elements', 'Bangalore', 'INOX', '2025-12-16 19:00:00', 168, 'https://images.unsplash.com/photo-1594908900066-3f47337549d8?w=400', 4.3, 250, true),
('RRR', 'MOVIES', 'Telugu', 'Action', 'Period action drama - A tale of two revolutionaries', 'Hyderabad', 'AMB Cinemas', '2025-12-17 20:00:00', 187, 'https://images.unsplash.com/photo-1574267432644-f610f5b7e4d1?w=400', 4.7, 280, true),
('IPL 2025 Final', 'SPORTS', 'English', 'Cricket', 'Indian Premier League Final Match', 'Mumbai', 'Wankhede Stadium', '2025-12-20 19:30:00', 240, 'https://images.unsplash.com/photo-1531415074968-036ba1b575da?w=400', 4.8, 1500, true),
('Arijit Singh Live', 'MUSIC', 'Hindi', 'Concert', 'Live concert by Arijit Singh', 'Bangalore', 'M Chinnaswamy Stadium', '2025-12-22 18:00:00', 180, 'https://images.unsplash.com/photo-1501281668745-f7f57925c3b4?w=400', 4.6, 2000, true),
('Pushpa 2', 'MOVIES', 'Telugu', 'Action', 'The rule continues - Mass action entertainer', 'Hyderabad', 'AMB Cinemas', '2025-12-25 21:00:00', 175, 'https://images.unsplash.com/photo-1598899134739-24c46f58b8c0?w=400', 4.4, 300, true);

INSERT INTO shows (event_id, venue_id, show_date, show_time, available_seats, price, is_active) VALUES
(1, 1, '2025-12-15', '2025-12-15 18:00:00', 300, 300, true),
(1, 1, '2025-12-15', '2025-12-15 21:00:00', 300, 300, true),
(2, 2, '2025-12-16', '2025-12-16 19:00:00', 250, 250, true),
(2, 2, '2025-12-16', '2025-12-16 22:00:00', 250, 250, true),
(3, 3, '2025-12-17', '2025-12-17 20:00:00', 400, 280, true),
(4, 4, '2025-12-20', '2025-12-20 19:30:00', 33000, 1500, true),
(5, 5, '2025-12-22', '2025-12-22 18:00:00', 40000, 2000, true),
(6, 3, '2025-12-25', '2025-12-25 21:00:00', 400, 300, true);

USE booking_db;
CREATE TABLE IF NOT EXISTS bookings (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    show_id BIGINT NOT NULL,
    event_id BIGINT NOT NULL,
    number_of_seats INT NOT NULL,
    total_amount DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'PENDING',
    booking_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS seats (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    seat_number VARCHAR(50),
    FOREIGN KEY (booking_id) REFERENCES bookings(id)
);

USE payment_db;
CREATE TABLE IF NOT EXISTS payments (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    booking_id BIGINT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(50),
    status VARCHAR(50) DEFAULT 'PENDING',
    transaction_id VARCHAR(255),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
