CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE courses (
    id SERIAL PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    description VARCHAR(70),
    price NUMERIC(10, 2) CHECK (price >= 0),
    duration_weeks INT CHECK (duration_weeks > 0)
);

CREATE TABLE teachers (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    phone VARCHAR(15),
    specialization VARCHAR(20) NOT NULL
);

CREATE TABLE groups (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    teacher_id INT REFERENCES teachers(id) ON DELETE SET NULL,
    start_date DATE NOT NULL
);

CREATE TABLE group_students (
    group_id INT REFERENCES groups(id) ON DELETE CASCADE,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    joined_at DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (group_id, student_id)
);

CREATE TABLE lessons (
    id SERIAL PRIMARY KEY,
    group_id INT REFERENCES groups(id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    lesson_date TIMESTAMP NOT NULL
);

CREATE TABLE homeworks (
    id SERIAL PRIMARY KEY,
    lesson_id INT REFERENCES lessons(id) ON DELETE CASCADE,
    title VARCHAR(100) NOT NULL,
    description VARCHAR(100),
    deadline TIMESTAMP NOT NULL
);

CREATE TABLE homework_submissions (
    id SERIAL PRIMARY KEY,
    homework_id INT REFERENCES homeworks(id) ON DELETE CASCADE,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    grade INT CHECK (grade BETWEEN 0 AND 100),
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    amount NUMERIC(10, 2) CHECK (amount > 0),
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE attendance (
    id SERIAL PRIMARY KEY,
    lesson_id INT REFERENCES lessons(id) ON DELETE CASCADE,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    is_present BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE certificates (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    certificate_code VARCHAR(50) UNIQUE NOT NULL,
    issued_date DATE DEFAULT CURRENT_DATE
);

CREATE TABLE student_progress (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    percent_completed INT CHECK (percent_completed BETWEEN 0 AND 100) DEFAULT 0
);

CREATE TABLE lesson_materials (
    id SERIAL PRIMARY KEY,
    lesson_id INT REFERENCES lessons(id) ON DELETE CASCADE,
    title VARCHAR(20) NOT NULL,
    material_url VARCHAR(50) NOT NULL
);

