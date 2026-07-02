-- Rooms table
CREATE TABLE Rooms (
    room_id INTEGER PRIMARY KEY AUTOINCREMENT,
    room_number VARCHAR(50) NOT NULL,
    capacity INTEGER
);

-- Allocations table: links a Student to a Room (many-to-one style)
CREATE TABLE Allocations (
    allocation_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER,
    room_id INTEGER,
    allocation_date DATE,

    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
