# Migrate Data from revtickets Database to Microservices

## Option 1: Using MySQL Workbench or Command Line

### Step 1: Export revtickets database
Open Command Prompt and run:
```bash
mysqldump -uroot -p12345 -h localhost -P 3306 revtickets > d:\RevTicket-MS\revtickets_backup.sql
```

### Step 2: Import to Docker MySQL
```bash
cd d:\RevTicket-MS
docker exec -i revticket-mysql mysql -uroot -p12345 < revtickets_backup.sql
```

### Step 3: Copy data to microservices databases
```bash
docker exec -i revticket-mysql mysql -uroot -p12345 < migrate-data-manual.sql
```

### Step 4: Restart services
```bash
docker-compose restart user-service event-service booking-service payment-service
```

## Option 2: Using MySQL Workbench GUI

1. Connect to localhost:3306 (your local MySQL)
2. Export revtickets database (Data Export)
3. Connect to localhost:3307 (Docker MySQL)
4. Import the dump file
5. Run the migrate-data-manual.sql script
6. Restart Docker services

## Option 3: Direct Copy (if both MySQL instances are accessible)

Run this in any MySQL client connected to Docker MySQL (localhost:3307):

```sql
-- First, ensure revtickets database is accessible
-- Then copy data:

INSERT IGNORE INTO user_db.users 
SELECT * FROM revtickets.users;

INSERT IGNORE INTO event_db.events 
SELECT * FROM revtickets.events;

INSERT IGNORE INTO event_db.venues 
SELECT * FROM revtickets.venues;

INSERT IGNORE INTO event_db.shows 
SELECT * FROM revtickets.shows;

INSERT IGNORE INTO booking_db.bookings 
SELECT * FROM revtickets.bookings;

INSERT IGNORE INTO booking_db.seats 
SELECT * FROM revtickets.seats;

INSERT IGNORE INTO payment_db.payments 
SELECT * FROM revtickets.payments;
```

After migration, restart services:
```bash
docker-compose restart user-service event-service booking-service payment-service
```
