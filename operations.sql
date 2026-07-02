-- operations.sql
-- Demonstrates required SQL operations on the Students table.

-- 1. Change a column name
ALTER TABLE Students
RENAME COLUMN age TO student_age;

-- 2. Add a new column
ALTER TABLE Students
ADD COLUMN email TEXT;

-- 3. Select data, filtered/sorted ascending
SELECT *
FROM Students
ORDER BY first_name ASC;

-- 4. Select data, filtered/sorted descending
SELECT *
FROM Students
ORDER BY student_age DESC;
