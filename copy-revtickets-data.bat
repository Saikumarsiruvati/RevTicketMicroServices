@echo off
echo Copying data from revtickets database to microservices databases...
echo.

echo This script will:
echo 1. Export data from revtickets (localhost:3306)
echo 2. Import to Docker MySQL (localhost:3307)
echo 3. Copy to microservices databases
echo.

echo Please run these commands manually in MySQL Workbench or any MySQL client:
echo.
echo Connect to localhost:3307 with root/12345
echo Then run this SQL:
echo.
type migrate-data-manual.sql
echo.
pause
