-- Лабораторная работа №1
-- Вариант 21
-- PostgreSQL

DROP TABLE IF EXISTS work_schedules CASCADE;
DROP TABLE IF EXISTS post_offices CASCADE;

-- 1. Почтовые отделения

CREATE TABLE post_offices (
    office_id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    address VARCHAR(150) NOT NULL,
    city VARCHAR(100) NOT NULL,
    district VARCHAR(100),
    postal_code VARCHAR(6) NOT NULL,
    phone VARCHAR(20) NOT NULL
);

-- 2. Графики работы

CREATE TABLE work_schedules (
    office_id INTEGER NOT NULL,
    department_id INTEGER NOT NULL,
    day_of_week VARCHAR(20) NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    break_start TIME,
    break_end TIME,

    PRIMARY KEY (office_id, department_id, day_of_week),

    CONSTRAINT fk_office
        FOREIGN KEY (office_id)
        REFERENCES post_offices(office_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,

    CHECK (start_time < end_time),
    CHECK (
        (break_start IS NULL AND break_end IS NULL)
        OR
        (break_start >= start_time
         AND break_start < break_end
         AND break_end <= end_time)
    )
);