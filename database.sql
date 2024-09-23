-- Step 1
CREATE TABLE Programs (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    cost INT,
    type VARCHAR(50),
    created_at TIMESTAMP,
    update_at TIMESTAMP
);

CREATE TABLE Modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR (50),
    description VARCHAR (255),
    created_at TIMESTAMP,
    update_at TIMESTAMP
);

CREATE TABLE Courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    title VARCHAR(255),
    created_at TIMESTAMP,
    updated_at TIMESTAMP,
    deleted BOOLEAN
);

CREATE TABLE Lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    title VARCHAR(50),
    body TEXT,
    video_link VARCHAR(255),
    number INT,
    created_at TIMESTAMP,
    update_at TIMESTAMP,
    course_id BIGINT REFERENCES Courses(id),
    deleted BOOLEAN
);

-- Связи табли
CREATE TABLE program_modules (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    program_id BIGINT REFERENCES Programs(id),
    module_id BIGINT REFERENCES Modules(id)
);

CREATE TABLE module_courses (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    module_id BIGINT REFERENCES Modules(id),
    course_id BIGINT REFERENCES Courses(id)
);

CREATE TABLE course_lessons (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    course_id BIGINT REFERENCES Courses(id),
    lesson_id BIGINT REFERENCES Lessons(id)
);

-- Пользователи и Группы (Step 2)
CREATE TYPE users_role AS ENUM ('student', 'teacher', 'admin');

CREATE TABLE TeachingGroups (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    slug VARCHAR (255),
    creared_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Users (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50),
    email VARCHAR(255),
    password TEXT,
    teachinggroup_id BIGINT REFERENCES TeachingGroups(id),
    role users_role,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

-- Step 3
CREATE TYPE enrollments_status AS ENUM ('active', 'pending', 'cancelled', 'completed');

CREATE TYPE payments_status AS ENUM ('pending', 'paid', 'failed', 'refunded');

CREATE TYPE programs_completions AS ENUM ('active', 'completed', 'pending', 'cancelled');

CREATE TABLE Enrollments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    enrollment_status enrollments_status,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Payments (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    enrollment_id BIGINT REFERENCES Enrollments(id),
    payment_amount payments_status,
    payment_date TIMESTAMP,
    created_at TIMESTAMP,
    update_at TIMESTAMP
);

CREATE TABLE ProgramCompletions (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Uers(id),
    program_id BIGINT REFERENCES Programs(id),
    completion_status programs_completions,
    start_program_date TIMESTAMP,
    finish_program_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE Certificates (
    id BIGINT PRIMARY KEY GENERATED ALWAYS AS IDENTITY,
    user_id BIGINT REFERENCES Users(id),
    program_id BIGINT REFERENCES Programs(id),
    url VARCHAR(50),
    certificate_date TIMESTAMP,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);
