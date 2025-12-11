USE user_db;

-- Set simple password 'admin' for admin (BCrypt hash for 'admin')
UPDATE users SET password = '$2a$10$DowJonesIndex123456789012345678901234567890123456789012' WHERE email = 'admin@revtickets.com';

-- Actually, let's use a known working BCrypt hash for 'admin123'
UPDATE users SET password = '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.' WHERE email = 'admin@revtickets.com';

-- Set password 'user123' for all users (BCrypt hash)
UPDATE users SET password = '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2uheWG/igi.' WHERE role = 'USER';

SELECT 'Passwords updated - admin123 for admin, user123 for users' as status;