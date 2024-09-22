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
    id BIGINT PRIMARY KEY GENERATED AS IDENTITY,
    course_id BIGINT REFERENCES Courses(id),
    lesson_id BIGINT REFERENCES Lessons(id)
);
