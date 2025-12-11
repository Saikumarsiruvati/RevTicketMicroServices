USE user_db;

-- Delete existing users and create simple test users
DELETE FROM users;

-- Insert admin with simple password (will be encoded by the service)
INSERT INTO users (id, name, email, password, phone, role, is_blocked, created_at, updated_at) VALUES
(1, 'Admin User', 'admin@revtickets.com', 'admin123', '9999999999', 'ADMIN', 0, NOW(), NOW()),
(2, 'Test User', 'user@test.com', 'user123', '8888888888', 'USER', 0, NOW(), NOW());

SELECT * FROM users;