-- 1. Преподаватели и курсы
INSERT INTO teachers (first_name, last_name, email, phone, specialization) VALUES
('Anel', 'K', 'anel@test.kz', '87011111111', 'DevOps'),
('Tomiris', 'A', 'tomiris@test.kz', '87022222222', 'Java'),
('Beknur', 'S', 'beknur@test.kz', '87033333333', 'Frontend');

INSERT INTO courses (title, description, price, duration_weeks) VALUES
('System Administration', 'Интенсивный курс', 100000.00, 6),
('Java Spring Boot', 'Java для продолжающих', 150000.00, 6),
('Web Development', 'Базовый курс по веб-разработке', 120000.00, 8);

-- 2. Студенты
INSERT INTO students (first_name, last_name, email, phone) VALUES
('Christiano', 'Ronaldo', 'cristiano_r@test.kz', '87776666666'),
('Lionel', 'Messi', 'messi_l@test.kz', '87775555555'),
('Lamine', 'Yamal', 'lamine_y@test.kz', '87774444444');

-- 3. Группы (teacher_id = 1, 2, 3)
INSERT INTO groups (name, course_id, teacher_id, start_date) VALUES
('SA-101', 1, 1, '2026-10-01'),
('JAVA-201', 2, 2, '2026-10-01'),
('WEB-301', 3, 3, '2026-10-01');

INSERT INTO group_students (group_id, student_id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- 4. Уроки и материалы
INSERT INTO lessons (group_id, title, lesson_date) VALUES
(1, 'Введение в администрирование', '2026-10-02 19:00:00'),
(2, 'Основы Java', '2026-10-02 19:00:00');

INSERT INTO homeworks (lesson_id, title, description, deadline) VALUES
(1, 'ДЗ №1', 'Настроить базовую сеть', '2026-10-10 23:59:00');

INSERT INTO homework_submissions (homework_id, student_id, grade) VALUES
(1, 1, 95);

INSERT INTO payments (student_id, course_id, amount, payment_date) VALUES
(1, 1, 100000.00, '2026-10-01 10:00:00'),
(2, 2, 100000.00, '2026-10-01 11:00:00');

INSERT INTO attendance (lesson_id, student_id, is_present) VALUES
(1, 1, true),
(1, 2, true);

INSERT INTO certificates (student_id, course_id, certificate_code, issued_date) VALUES
(1, 1, 'CERT-SA-001', '2026-11-01'),
(2, 2, 'CERT-JAVA-002', '2026-11-01');

INSERT INTO student_progress (student_id, course_id, percent_completed) VALUES
(1, 1, 100),
(2, 2, 75),
(3, 3, 30);

INSERT INTO lesson_materials (lesson_id, title, material_url) VALUES
(1, 'Презентация к уроку 1', 'https://materials.test/lesson1.pdf');

