package com.revtickets;

import java.sql.*;

public class DataMigrator {
    private static final String SOURCE_URL = "jdbc:mysql://localhost:3306/revtickets";
    private static final String TARGET_URL = "jdbc:mysql://localhost:3307/";
    private static final String USER = "root";
    private static final String PASSWORD = "12345";

    public static void main(String[] args) {
        System.out.println("========================================");
        System.out.println("RevTicket Data Migration Tool");
        System.out.println("========================================\n");

        try {
            migrateTable("users", "user_db");
            migrateTable("events", "event_db");
            migrateTable("venues", "event_db");
            migrateTable("shows", "event_db");
            migrateTable("bookings", "booking_db");
            migrateTable("seats", "booking_db");
            migrateTable("payments", "payment_db");
            
            System.out.println("\n========================================");
            System.out.println("Migration completed successfully!");
            System.out.println("========================================");
        } catch (Exception e) {
            System.err.println("Migration failed: " + e.getMessage());
            e.printStackTrace();
        }
    }

    private static void migrateTable(String tableName, String targetDb) throws SQLException {
        System.out.println("Migrating " + tableName + "...");
        try (Connection source = DriverManager.getConnection(SOURCE_URL, USER, PASSWORD);
             Connection target = DriverManager.getConnection(TARGET_URL + targetDb, USER, PASSWORD)) {
            
            String select = "SELECT * FROM " + tableName;
            
            try (Statement stmt = source.createStatement();
                 ResultSet rs = stmt.executeQuery(select)) {
                
                ResultSetMetaData metaData = rs.getMetaData();
                int columnCount = metaData.getColumnCount();
                
                StringBuilder insertSql = new StringBuilder("INSERT IGNORE INTO " + tableName + " VALUES (");
                for (int i = 0; i < columnCount; i++) {
                    insertSql.append("?");
                    if (i < columnCount - 1) insertSql.append(", ");
                }
                insertSql.append(")");
                
                try (PreparedStatement pstmt = target.prepareStatement(insertSql.toString())) {
                    int count = 0;
                    while (rs.next()) {
                        for (int i = 1; i <= columnCount; i++) {
                            pstmt.setObject(i, rs.getObject(i));
                        }
                        pstmt.addBatch();
                        count++;
                        
                        if (count % 100 == 0) {
                            pstmt.executeBatch();
                        }
                    }
                    pstmt.executeBatch();
                    System.out.println("  → " + count + " records copied");
                }
            }
            System.out.println("✓ " + tableName + " migrated");
        }
    }
}
