-- Ejercicio 2: CREACIÓN DE BASE DE DATOS

DROP TABLE IF EXISTS alumno;
DROP TABLE IF EXISTS profesor;
DROP TABLE IF EXISTS bootcamp;
DROP TABLE IF EXISTS alumno_bootcamp;
DROP TABLE IF EXISTS modulo;
DROP TABLE IF EXISTS modulo_bootcamp;
DROP TABLE IF EXISTS curso;
DROP TABLE IF EXISTS alumno_curso;

-- Crear tabla alumno
CREATE TABLE alumno (
    alumno_id SERIAL PRIMARY KEY,
    dni VARCHAR(50) UNIQUE NOT NULL,   
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    telefono VARCHAR(50) NOT NULL
);

-- Crear tabla profesor
CREATE TABLE profesor (
    profesor_id SERIAL PRIMARY KEY,
    dni VARCHAR(50) UNIQUE NOT NULL,   
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    email VARCHAR(50) UNIQUE NOT NULL,
    especialidad VARCHAR(50) NOT NULL
);

-- Crear tabla bootcamp
CREATE TABLE bootcamp (
    bootcamp_id SERIAL PRIMARY KEY,
    descripcion VARCHAR(100) NOT NULL,
    profesor_id INT NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES profesor(profesor_id),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);

-- Crear la tabla alumno_bootcamp (relación muchos a muchos entre alumno y bootcamp)
CREATE TABLE alumno_bootcamp (
    alumno_bootcamp_id SERIAL PRIMARY KEY,
    alumno_id INT,
    bootcamp_id INT,
    FOREIGN KEY (alumno_id) REFERENCES alumno(alumno_id),
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id),
    UNIQUE (alumno_id, bootcamp_id)
);

-- Crear tabla modulo
CREATE TABLE modulo (
    modulo_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    num_clases INT NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    profesor_id INT NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES profesor(profesor_id)
);

-- Crear la tabla modulo_bootcamp (relación muchos a muchos entre modulo y bootcamp)
CREATE TABLE modulo_bootcamp (
    modulo_bootcamp_id SERIAL PRIMARY KEY,
    modulo_id INT,
    bootcamp_id INT,
    FOREIGN KEY (modulo_id) REFERENCES modulo(modulo_id),
    FOREIGN KEY (bootcamp_id) REFERENCES bootcamp(bootcamp_id),
    UNIQUE (modulo_id, bootcamp_id)
);

-- Crear tabla curso
CREATE TABLE curso (
    curso_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    num_videos INT NOT NULL,
    duracion_horas DECIMAL(4, 2) NOT NULL,
    profesor_id INT NOT NULL,
    FOREIGN KEY (profesor_id) REFERENCES profesor(profesor_id)
);

-- Crear la tabla alumno_curso (relación muchos a muchos entre alumno y curso)
CREATE TABLE alumno_curso (
    alumno_bootcamp_id SERIAL PRIMARY KEY,
    alumno_id INT,
    curso_id INT,
    FOREIGN KEY (alumno_id) REFERENCES alumno(alumno_id),
    FOREIGN KEY (curso_id) REFERENCES curso(curso_id),
    UNIQUE (alumno_id, curso_id)
);

INSERT INTO alumno (dni, nombre, apellidos, email, telefono) VALUES
('12345678A','Ana', 'González Sánchez', 'ana.gonzalez@email.com', '912-222333'),
('23456789A','Juan', 'Martínez García', 'juan.martinez@email.com', '944-555666'),
('34567890Z','Laura', 'Hernández Blanco', 'laura.hernandez@email.com', '977-888999');

INSERT INTO profesor (dni, nombre, apellidos, email, especialidad) VALUES
('12345678K','Pedro', 'Blanco Taylor', 'pedro.blanco@email.com', 'matematicas'),
('23456789L','Isabel', 'Molina Fernández', 'isabel.molina@email.com', 'machine learning'),
('34567890M','Sergio', 'Vidal Pérez', 'sergio.vidal@email.com', 'big data processing'),
('45678901N','Lucía', 'Fernández Gómez', 'lucia.fernandez@email.com', 'prompt engineering');

INSERT INTO bootcamp (descripcion, profesor_id, fecha_inicio, fecha_fin, precio) VALUES
('Full Stack Jr. Bootcamp', 1, DATE '2024-07-01', DATE '2024-11-03', 4000.00),
('Bootcamp Java Full Stack', 2, DATE '2024-07-01', DATE '2025-02-15', 5000.00),
('Inteligencia Artificial Full Stack Bootcamp', 3, DATE '2024-07-01', DATE '2025-04-20', 6000.00);

INSERT INTO modulo (nombre, num_clases, fecha_inicio, fecha_fin, profesor_id) VALUES
('Estadística', 4, DATE '2024-09-01', DATE '2024-10-03', 3),
('Machine Learning', 6, DATE '2024-11-01', DATE '2024-12-03', 4),
('Inteligencia Artificial', 6, DATE '2025-01-15', DATE '2025-02-15', 4);

INSERT INTO curso (nombre, num_videos, duracion_horas, profesor_id) VALUES
('Introducción a R', 20, 12.5, 3),
('Introducción a Git y GitHub', 30, 14.8, 1),
('Introducción a Python', 40, 12.8, 2);

INSERT INTO alumno_bootcamp (alumno_id, bootcamp_id) VALUES
  (1, 3),
  (2, 2),
  (3, 3);

INSERT INTO modulo_bootcamp (modulo_id, bootcamp_id) VALUES
  (1, 3),
  (2, 3),
  (3, 3);

INSERT INTO alumno_curso (alumno_id, curso_id) VALUES
  (1, 2),
  (2, 3),
  (3, 1);