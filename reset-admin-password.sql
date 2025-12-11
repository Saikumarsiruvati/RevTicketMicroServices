USE revtickets;
UPDATE users SET password = 'admin123' WHERE email = 'admin@revtickets.com';
SELECT email, password FROM users WHERE email = 'admin@revtickets.com';
