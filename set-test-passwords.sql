-- Set known passwords for testing
-- Password: admin123 (BCrypt encoded)
USE user_db;

UPDATE users SET password = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy' WHERE email = 'admin@revtickets.com';

-- Password: user123 (BCrypt encoded) 
UPDATE users SET password = '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy' WHERE role = 'USER';

-- Show updated users
SELECT id, name, email, role, 'Password set to: admin123 for admin, user123 for users' as password_info FROM users ORDER BY role DESC, id;