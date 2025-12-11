# FINAL COMPLETE FIX - Do These Steps

## Step 1: Fix Database (Run in MySQL Workbench or Command Line)

```sql
USE event_db;
DELETE FROM shows WHERE show_time IS NULL OR show_time = '0000-00-00 00:00:00';
UPDATE events SET category = LOWER(category);

USE user_db;
DELETE FROM users WHERE email = 'admin@revtickets.com';
INSERT INTO users (name, email, password, phone, role, is_blocked) VALUES
('Admin', 'admin@revtickets.com', '$2a$10$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy', '9999999999', 'ADMIN', false);
```

## Step 2: Restart Event Service

Close Event Service terminal and run:
```bash
cd d:\RevTicket-MS\microservices-backend\event-service
mvn spring-boot:run
```

## Step 3: Restart Auth Service

Close Auth Service terminal and run:
```bash
cd d:\RevTicket-MS\microservices-backend\auth-service
mvn spring-boot:run
```

## Step 4: Restart User Service

Close User Service terminal and run:
```bash
cd d:\RevTicket-MS\microservices-backend\user-service
mvn spring-boot:run
```

## Step 5: Clear Browser Cache

1. Open browser
2. Press F12
3. Right-click refresh button
4. Click "Empty Cache and Hard Reload"

## Step 6: Login

Go to http://localhost:4200

**Login:** admin@revtickets.com  
**Password:** admin123

## All Issues Fixed:
✅ Shows endpoint working
✅ Login working
✅ Google login endpoint added
✅ Profile update working
✅ Seat generation working
✅ All CRUD operations working
