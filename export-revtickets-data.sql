-- Export data from revtickets database
-- Run this on LOCAL MySQL (localhost:3306)

-- Users data
SELECT * FROM revtickets.users INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/users.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Events data
SELECT * FROM revtickets.events INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/events.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Venues data
SELECT * FROM revtickets.venues INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/venues.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Shows data
SELECT * FROM revtickets.shows INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/shows.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Bookings data
SELECT * FROM revtickets.bookings INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bookings.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Seats data
SELECT * FROM revtickets.seats INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/seats.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Payments data
SELECT * FROM revtickets.payments INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/payments.csv'
FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
