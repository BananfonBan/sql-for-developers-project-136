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

-- Связи таблиц

CREATE TABLE
