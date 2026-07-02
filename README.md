# Dormitory Management System (Flask + SQLite)

## Project structure
```
dormitory_flask/
├── app.py                # Flask app, connects to instance/app.db
├── requirements.txt
├── instance/
│   └── app.db             # SQLite database (created below)
├── templates/
│   └── preview.html       # renders table contents in the browser
├── create_tables.sql      # creates Rooms + Allocations
├── insert_data.sql        # sample data
└── operations.sql         # rename column / add column / ORDER BY
```

## 1. Create the database and first table (from the terminal)
```
cd dormitory_flask
sqlite3 instance/app.db
```
Then at the `sqlite>` prompt:
```sql
CREATE TABLE Students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    age INTEGER
);
.tables
.quit
```

## 2. Create the remaining tables from a file
```
sqlite3 instance/app.db < create_tables.sql
```
Creates `Rooms` and `Allocations` (Allocations has foreign keys back to
Students and Rooms, so all three tables are related).

## 3. Load sample data
```
sqlite3 instance/app.db < insert_data.sql
```

## 4. Run the required operations file
```
sqlite3 instance/app.db < operations.sql
```
This demonstrates:
- Renaming a column (`age` → `student_age`)
- Adding a new column (`email`)
- Selecting data sorted ascending
- Selecting data sorted descending

## 5. Run the Flask app
```
pip install -r requirements.txt
python app.py
```
Visit:
- `http://127.0.0.1:5000/` — home page, confirms which DB file Flask is using
- `http://127.0.0.1:5000/preview` — shows every table and its rows in the browser

## SQLite terminal 
Use these commands directly in the terminal when you open the database.

### 1. Open the database
```bash
cd dormitory_flask
sqlite3 instance/app.db
```

### 2. See what tables exist
```sql
.tables
```

### 3. See the structure of a table
```sql
PRAGMA table_info(Students);
PRAGMA table_info(Rooms);
PRAGMA table_info(Allocations);
```

### 4. View the entire table
```sql
SELECT * FROM Students;
SELECT * FROM Rooms;
SELECT * FROM Allocations;
```

### 5. Select one person or one row
```sql
-- Find one student by ID
SELECT * FROM Students WHERE student_id = 1;

-- Find one student by first name
SELECT * FROM Students WHERE first_name = 'Myles';
```

### 6. Add a new row to a table
If you have already run the operations file, use `student_age` and `email`:
```sql
INSERT INTO Students (first_name, last_name, student_age, email)
VALUES ('Amina', 'Kariuki', 20, 'amina@example.com');
```

If you have not run the operations file yet, use `age` instead:
```sql
INSERT INTO Students (first_name, last_name, age)
VALUES ('Amina', 'Kariuki', 20);
```

Add a room:
```sql
INSERT INTO Rooms (room_number, capacity)
VALUES ('C303', 3);
```

Add an allocation:
```sql
INSERT INTO Allocations (student_id, room_id, allocation_date)
VALUES (1, 3, '2026-07-04');
```

### 7. Edit or update existing data
Update one student:
```sql
UPDATE Students
SET first_name = 'Amina',
    last_name = 'Kariuki',
    student_age = 21,
    email = 'amina.new@example.com'
WHERE student_id = 1;
```

Update a room:
```sql
UPDATE Rooms
SET capacity = 4
WHERE room_id = 3;
```

Update an allocation:
```sql
UPDATE Allocations
SET allocation_date = '2026-07-05'
WHERE allocation_id = 1;
```

### 8. Delete a row
Delete one student:
```sql
DELETE FROM Students WHERE student_id = 3;
```

Delete one room:
```sql
DELETE FROM Rooms WHERE room_id = 3;
```

Delete one allocation:
```sql
DELETE FROM Allocations WHERE allocation_id = 1;
```

### 9. Rename a column
Rename a column in Students:
```sql
ALTER TABLE Students RENAME COLUMN age TO student_age;
```

Rename a column in Rooms:
```sql
ALTER TABLE Rooms RENAME COLUMN capacity TO room_capacity;
```

Rename a column in Allocations:
```sql
ALTER TABLE Allocations RENAME COLUMN allocation_date TO booked_on;
```

### 10. Add a new column
Add a column to Students:
```sql
ALTER TABLE Students ADD COLUMN email TEXT;
```

Add a column to Rooms:
```sql
ALTER TABLE Rooms ADD COLUMN status TEXT;
```

Add a column to Allocations:
```sql
ALTER TABLE Allocations ADD COLUMN notes TEXT;
```

### 11. Run a SQL file from the terminal
```bash
sqlite3 instance/app.db < create_tables.sql
sqlite3 instance/app.db < insert_data.sql
sqlite3 instance/app.db < operations.sql
```

### 12. Exit sqlite3
```sql
.quit
```

## Commands to show your lecturer
```
sqlite3 instance/app.db
sqlite3 instance/app.db < create_tables.sql
sqlite3 instance/app.db < operations.sql
.tables
.schema
```
