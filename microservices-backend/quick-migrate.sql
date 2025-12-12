-- Run this on LOCAL MySQL to export data, then import to Docker

-- Export venues
SELECT * FROM revtickets.venues INTO OUTFILE 'C:/temp/venues.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Export shows  
SELECT * FROM revtickets.shows INTO OUTFILE 'C:/temp/shows.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Export bookings
SELECT * FROM revtickets.bookings INTO OUTFILE 'C:/temp/bookings.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Export seats
SELECT * FROM revtickets.seats INTO OUTFILE 'C:/temp/seats.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';

-- Export payments
SELECT * FROM revtickets.payments INTO OUTFILE 'C:/temp/payments.csv' FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n';
