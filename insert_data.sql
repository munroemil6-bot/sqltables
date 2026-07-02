INSERT INTO Students (first_name, last_name, student_age, email) VALUES
('Myles', 'Munroe', 19, 'myles@gmail.com'),
('Naomi', 'Nafula', 19, 'naomi@gmail.com'),
('Peter', 'Muturi', 27, 'peter@gmail.com');

INSERT INTO Rooms (room_number, capacity) VALUES
('A101', 2),
('B202', 4);

INSERT INTO Allocations (student_id, room_id, allocation_date) VALUES
(1, 1, '01/07/2026'),
(2, 2, '02/07/2026'),
(3, 1, '03/07/2026');
