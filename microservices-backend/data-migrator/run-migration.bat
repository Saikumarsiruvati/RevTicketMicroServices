@echo off
echo ========================================
echo Building Data Migration Tool
echo ========================================
cd data-migrator
call mvn clean compile

echo.
echo ========================================
echo Running Data Migration
echo ========================================
call mvn exec:java -Dexec.mainClass="com.revtickets.DataMigrator"

echo.
pause
