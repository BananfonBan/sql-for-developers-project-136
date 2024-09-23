DROP TABLE IF EXISTS courses,
lessons,
modules,
programs,
course_modules,
program_modules,
teaching_groups,
users,
enrollments,
payments,
program_completions,
certificates,
quizzes,
exercises,
discussions,
blogs CASCADE;

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
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
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
    course_id BIGINT REFERENCES courses(id) ON DELETE SET NULL,
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
    program_id BIGINT REFERENCES programs(id) ON DELETE CASCADE,
    module_id BIGINT REFERENCES modules(id) ON DELETE CASCADE,
    PRIMARY KEY (program_id, module_id)
);

CREATE TABLE course_modules (
    module_id BIGINT REFERENCES modules(id) ON DELETE CASCADE,
    course_id BIGINT REFERENCES courses(id) ON DELETE CASCADE,
    PRIMARY KEY (module_id, course_id)
);

-- Step 2
CREATE TABLE teaching_groups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(255),
    email VARCHAR(255),
    password_hash TEXT,
    teaching_group_id BIGINT REFERENCES teaching_groups(id) ON DELETE SET NULL,
    role users_role NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted_at BOOLEAN DEFAULT FALSE
);

-- Step 3
CREATE TABLE enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs(id) ON DELETE SET NULL,
    status enrollments_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES enrollments(id) ON DELETE SET NULL,
    amount NUMERIC,
    status payments_status NOT NULL,
    paid_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE program_completions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs(id) ON DELETE SET NULL,
    status programs_completions NOT NULL,
    started_at TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    program_id BIGINT REFERENCES programs(id) ON DELETE SET NULL,
    url VARCHAR(255),
    issued_at TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Step 4
CREATE TABLE quizzes (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id) ON DELETE SET NULL,
    name VARCHAR(255),
    content TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE exercises (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id) ON DELETE SET NULL,
    name VARCHAR(255),
    url VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE discussions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    lesson_id BIGINT REFERENCES lessons(id) ON DELETE SET NULL,
    user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    text TEXT,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE blogs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES users(id) ON DELETE SET NULL,
    name VARCHAR(255),
    content TEXT,
    status articles_status NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
