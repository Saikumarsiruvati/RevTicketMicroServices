# Database Connection Information

## MongoDB

### From Your Machine (External):
```
Host: localhost
Port: 27018
Connection String: mongodb://localhost:27018
```

### From Docker Containers (Internal):
```
Host: mongo
Port: 27017
Connection String: mongodb://mongo:27017
```

### MongoDB Compass:
```
mongodb://localhost:27018
```

## MySQL

### From Your Machine (External):
```
Host: localhost
Port: 3307
Username: root
Password: 12345
Connection String: jdbc:mysql://localhost:3307/
```

### From Docker Containers (Internal):
```
Host: mysql
Port: 3306
Username: root
Password: 12345
Connection String: jdbc:mysql://mysql:3306/
```

### MySQL Workbench:
```
Host: localhost
Port: 3307
Username: root
Password: 12345
```

## Databases Created:
- user_db (MySQL)
- event_db (MySQL)
- booking_db (MySQL)
- payment_db (MySQL)
- notification_db (MongoDB)
- review_db (MongoDB)

## Why Different Ports?

Docker maps internal ports to external ports to avoid conflicts:
- MongoDB: 27017 (internal) → 27018 (external)
- MySQL: 3306 (internal) → 3307 (external)

This allows you to run local databases on standard ports while Docker uses different ports.
