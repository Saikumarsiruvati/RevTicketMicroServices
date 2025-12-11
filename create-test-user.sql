-- Create test user for login
USE user_db;

-- Insert test user (password: test123)
INSERT INTO users (name, email, password, phone, role, is_blocked, created_at, updated_at) 
VALUES (
    'Test User', 
    'test@test.com', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    '1234567890',
    'USER',
    0,
    NOW(),
    NOW()
);

-- Insert admin user (password: admin123)
INSERT INTO users (name, email, password, phone, role, is_blocked, created_at, updated_at) 
VALUES (
    'Admin User', 
    'admin@revtickets.com', 
    '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
    '9876543210',
    'ADMIN',
    0,
    NOW(),
    NOW()
);

SELECT * FROM users;
