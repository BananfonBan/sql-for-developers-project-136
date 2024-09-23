--Создание Перечисляемых типов (ENUM)
CREATE TYPE users_role AS ENUM ('студент', 'учитель', 'админ');

CREATE TYPE enrollments_status AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TYPE payments_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TYPE programs_completions AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TYPE articles_status AS ENUM ('created', 'in moderation', 'published', 'archived');

-- Step 1
CREATE TABLE programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    price NUMERIC,
    program_type VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR (255),
    description VARCHAR (255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    description TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

CREATE TABLE lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES courses(id) NOT NULL,
    name VARCHAR(255),
    content TEXT,
    video_url VARCHAR(255),
    position INT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

-- Связи таблиц
CREATE TABLE program_modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES programs(id) NOT NULL,
    module_id BIGINT REFERENCES modules(id)
);

CREATE TABLE module_courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES modules(id) NOT NULL,
    course_id BIGINT REFERENCES courses(id)
);

CREATE TABLE course_lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES courses(id) NOT NULL,
    lesson_id BIGINT REFERENCES lessons(id)
);

-- Step 2
CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR (255),
    creared_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    email VARCHAR(255),
    password_hash TEXT,
    teachinggroup_id BIGINT REFERENCES teaching_groups(id) NOT NULL,
    role users_role NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Step 3
CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) NOT NULL,
    program_id BIGINT REFERENCES programs(id) NOT NULL,
    status enrollments_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments(id) NOT NULL,
    amount NUMERIC,
    payment_amount payments_status NOT NULL,
    payment_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) NOT NULL,
    program_id BIGINT REFERENCES programs(id) NOT NULL,
    status programs_completions NOT NULL,
    start_program_date TIMESTAMP,
    finish_program_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) NOT NULL,
    program_id BIGINT REFERENCES programs(id) NOT NULL,
    url VARCHAR(255),
    certificate_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Step 4
CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
    title VARCHAR(255),
    body TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
    name VARCHAR(255),
    url VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id) NOT NULL,
    text TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE blogs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) NOT NUll,
    name VARCHAR(255),
    content TEXT,
    status articles_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
