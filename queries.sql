
-- 1. Список студентов с их группами и курсами
SELECT 
    s.id AS student_id,
    s.first_name || ' ' || s.last_name AS student_name,
    g.name AS group_name,
    c.title AS course_title
FROM students s
JOIN group_students gs ON s.id = gs.student_id
JOIN groups g ON gs.group_id = g.id
JOIN courses c ON g.course_id = c.id
ORDER BY s.id;


-- 2. Задолженности по оплате
SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    c.title AS course_title,
    c.price AS full_price,
    COALESCE(SUM(p.amount), 0) AS total_paid,
    (c.price - COALESCE(SUM(p.amount), 0)) AS debt
FROM students s
JOIN group_students gs ON s.id = gs.student_id
JOIN groups g ON gs.group_id = g.id
JOIN courses c ON g.course_id = c.id
LEFT JOIN payments p ON s.id = p.student_id AND c.id = p.course_id
GROUP BY s.id, s.first_name, s.last_name, c.id, c.title, c.price
HAVING (c.price - COALESCE(SUM(p.amount), 0)) > 0;


-- 3. Средний прогресс студентов по курсам
SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    c.title AS course_title,
    sp.percent_completed,
    ROUND(AVG(hs.grade), 1) AS avg_grade
FROM students s
JOIN student_progress sp ON s.id = sp.student_id
JOIN courses c ON sp.course_id = c.id
LEFT JOIN homework_submissions hs ON s.id = hs.student_id
GROUP BY s.id, s.first_name, s.last_name, c.title, sp.percent_completed;


-- 4. Посещаемость по группам в процентах
SELECT 
    g.name AS group_name,
    COUNT(a.id) AS total_records,
    COUNT(CASE WHEN a.is_present = true THEN 1 END) AS present_count,
    ROUND(
        (COUNT(CASE WHEN a.is_present = true THEN 1 END)::NUMERIC / NULLIF(COUNT(a.id), 0)) * 100, 
        2
    ) AS attendance_percentage
FROM groups g
JOIN lessons l ON g.id = l.group_id
JOIN attendance a ON l.id = a.lesson_id
GROUP BY g.id, g.name;


-- 5. Студенты, которые не сдали домашнее задание
SELECT 
    s.first_name || ' ' || s.last_name AS student_name,
    g.name AS group_name,
    h.title AS homework_title,
    h.deadline
FROM students s
JOIN group_students gs ON s.id = gs.student_id
JOIN groups g ON gs.group_id = g.id
JOIN lessons l ON g.id = l.group_id
JOIN homeworks h ON l.id = h.lesson_id
LEFT JOIN homework_submissions hs ON h.id = hs.homework_id AND s.id = hs.student_id
WHERE hs.id IS NULL;
