-- Insert test user into user_db
-- Password is 'password123' (BCrypt encoded)
USE user_db;

INSERT INTO users (name, email, password, phone, role, is_blocked) 
VALUES ('Test User', 'test@example.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '1234567890', 'USER', false);

-- Insert admin user
-- Password is 'admin123' (BCrypt encoded)
INSERT INTO users (name, email, password, phone, role, is_blocked) 
VALUES ('Admin User', 'admin@revtickets.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '9876543210', 'ADMIN', false);
