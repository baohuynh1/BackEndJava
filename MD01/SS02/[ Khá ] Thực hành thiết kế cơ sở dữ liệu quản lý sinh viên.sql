CREATE TABLE university.Students (
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
birth_date DATE,
email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE university.Courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100) NOT NULL,
 credits INTEGER
);

CREATE TABLE university.Enrollments (
enrollment_id SERIAL PRIMARY KEY,
student_id INTEGER REFERENCES university.Students(student_id),
course_id INTEGER REFERENCES university.Courses(course_id),
enroll_date DATE DEFAULT CURRENT_DATE
);

SELECT datname FROM pg_database;

SELECT schema_name FROM information_schema.schemata
WHERE schema_name = 'university';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university' AND table_name = 'students';

SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_schema = 'university' AND table_name = 'enrollments';

