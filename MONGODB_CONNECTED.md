# MongoDB Connection - SUCCESS ✅

## Connected to MongoDB

**Connection String:** `mongodb://localhost:27018`

## Databases Created:

1. **notification_db** - 8 KB
   - Collection: notifications
   - Sample data inserted

2. **review_db** - 8 KB
   - Collection: reviews
   - Sample data inserted

## Verify Connection:

### Using MongoDB Compass:
```
mongodb://localhost:27018
```

### Using mongosh:
```bash
docker exec -it revticket-mongo mongosh
```

### From Command Line:
```bash
mongosh mongodb://localhost:27018
```

## Sample Data Inserted:

### notification_db.notifications:
```json
{
  "userId": 1,
  "message": "Test notification",
  "read": false,
  "createdAt": "2025-12-12T13:19:43.000Z"
}
```

### review_db.reviews:
```json
{
  "eventId": 1,
  "userId": 1,
  "rating": 5,
  "comment": "Great event!",
  "createdAt": "2025-12-12T13:19:57.000Z"
}
```

## Status: CONNECTED AND WORKING ✅
