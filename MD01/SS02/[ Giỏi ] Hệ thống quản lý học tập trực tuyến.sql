-- Bảng Sinh viên
CREATE TABLE elearning.Students (
student_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE
);

-- Bảng Giảng viên
CREATE TABLE elearning.Instructors (
instructor_id SERIAL PRIMARY KEY,
first_name VARCHAR(50) NOT NULL,
last_name VARCHAR(50) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE
);

CREATE TABLE elearning.Courses (
course_id SERIAL PRIMARY KEY,
course_name VARCHAR(100) NOT NULL,
instructor_id INTEGER REFERENCES elearning.Instructors(instructor_id)
);

CREATE TABLE elearning.Enrollments (
enrollment_id SERIAL PRIMARY KEY,
student_id INTEGER REFERENCES elearning.Students(student_id),
course_id INTEGER REFERENCES elearning.Courses(course_id),
enroll_date DATE NOT NULL DEFAULT CURRENT_DATE
);

CREATE TABLE elearning.Assignments (
assignment_id SERIAL PRIMARY KEY,
course_id INTEGER REFERENCES elearning.Courses(course_id),
title VARCHAR(100) NOT NULL,
due_date TIMESTAMP NOT NULL
);


CREATE TABLE elearning.Submissions (
submission_id SERIAL PRIMARY KEY,
assignment_id INTEGER REFERENCES elearning.Assignments(assignment_id),
student_id INTEGER REFERENCES elearning.Students(student_id),
submission_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
grade NUMERIC(5, 2) CHECK (grade >= 0 AND grade <= 100) -- Điểm từ 0-100
);

SELECT datname FROM pg_database WHERE datistemplate = false;

SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'elearning';

SELECT column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'elearning' AND table_name = 'submissions';