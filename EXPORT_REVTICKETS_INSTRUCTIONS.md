# How to Export revtickets Database

## Option 1: Using MySQL Workbench (Easiest)

1. Open MySQL Workbench
2. Connect to localhost:3306 (root/12345)
3. Click on "Server" → "Data Export"
4. Select "revtickets" database
5. Choose "Export to Self-Contained File"
6. Set path to: `d:\RevTicket-MS\revtickets_dump.sql`
7. Click "Start Export"
8. Share the file `d:\RevTicket-MS\revtickets_dump.sql` with me

## Option 2: Using Command Prompt (if mysqldump is available)

Open Command Prompt and run:
```cmd
cd "C:\Program Files\MySQL\MySQL Server 8.0\bin"
mysqldump -uroot -p12345 -h localhost -P 3306 revtickets > d:\RevTicket-MS\revtickets_dump.sql
```

Or if MySQL 9.0:
```cmd
cd "C:\Program Files\MySQL\MySQL Server 9.0\bin"
mysqldump -uroot -p12345 -h localhost -P 3306 revtickets > d:\RevTicket-MS\revtickets_dump.sql
```

## Option 3: Using phpMyAdmin (if installed)

1. Open phpMyAdmin
2. Select "revtickets" database
3. Click "Export" tab
4. Click "Go"
5. Save file as `d:\RevTicket-MS\revtickets_dump.sql`

## After Export

Once you have the file `d:\RevTicket-MS\revtickets_dump.sql`, tell me and I will:
1. Import it to Docker MySQL
2. Copy data to microservices databases
3. Restart services

The file will be at: **d:\RevTicket-MS\revtickets_dump.sql**
