-- Creamos la base de datos si no existe
-- ya que como se esta trabajando con un computador publico, pues ya estan esas bases de datos creadas

-- DROP DATABASE control_usuarios; 

CREATE DATABASE IF NOT EXISTS control_usuarios;
USE control_usuarios;

-- Crear tabla de roles
-- testeado, funciona correctamente
CREATE TABLE IF NOT EXISTS roles (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

-- Crear tabla de permisos
-- testeado, funciona correctamente
CREATE TABLE IF NOT EXISTS permisos (
    id_permiso INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);
-- testeado, funciona correctamente
CREATE TABLE IF NOT EXISTS rol_permiso (
    id_rol_permiso INT AUTO_INCREMENT PRIMARY KEY,
    id_rol INT,
    id_permiso INT,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol) ON DELETE CASCADE,
    FOREIGN KEY (id_permiso) REFERENCES permisos(id_permiso) ON DELETE CASCADE
);


-- Crear tabla de usuarios
-- testrado, funciona correctamente
CREATE TABLE IF NOT EXISTS usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(300) UNIQUE NOT NULL,
    clave VARCHAR(500) NOT NULL,
    id_rol INT,
    FOREIGN KEY (id_rol) REFERENCES roles(id_rol) ON DELETE SET NULL
);


INSERT INTO roles (nombre) VALUES
('Administrador'),
('Empleado'),
('Supervisor'),
('Cliente');

INSERT INTO permisos (nombre, descripcion) VALUES
('Crear', 'Permite crear nuevos registros'),
('Leer', 'Permite visualizar registros'),
('Actualizar', 'Permite modificar registros existentes'),
('Eliminar', 'Permite eliminar registros'),
('Exportar', 'Permite exportar reportes'),
('Aprobar', 'Permite aprobar solicitudes');


INSERT INTO rol_permiso (id_rol, id_permiso) VALUES
(1, 1), -- Crear
(1, 2), -- Leer
(1, 3), -- Actualizar
(1, 4), -- Eliminar
(1, 5), -- Exportar
(1, 6); -- Aprobar

-- Asignar permisos al Empleado (id_rol = 2) → solo Leer y Crear
INSERT INTO rol_permiso (id_rol, id_permiso) VALUES
(2, 1),
(2, 2);

-- Asignar permisos al Supervisor (id_rol = 3) → Leer, Actualizar, Aprobar
INSERT INTO rol_permiso (id_rol, id_permiso) VALUES
(3, 2),
(3, 3),
(3, 6);

INSERT INTO usuarios (nombre, email, clave, id_rol) VALUES
('Admin', 'admin@gmail.com', '$2b$10$wLyudM5p.D5YekcUa2uSOQlRXvXFyKmpz3go/ryHgHUlihTioa6', 1),
('Empleado', 'empleado@gmail.com', '$2b$10$wLyudM5p.D5YekcUa2uSOQlRXvXFyKmpz3go/ryHgHUlihTioa6', 2),
('Supervisor', 'supervisor@gmail.com', '$2b$10$wLyudM5p.D5YekcUa2uSOQlRXvXFyKmpz3go/ryHgHUlihTioa6', 3),
('Cliente', 'cliente@gmail.com', '$2b$10$wLyudM5p.D5YekcUa2uSOQlRXvXFyKmpz3go/ryHgHUlihTioa6', 4),
('Maria Lopez', 'maria.lopez@gmail.com', '$2b$10$wLyudM5p.D5YekcUa2uSOQlRXvXFyKmpz3go/ryHgHUlihTioa6', 2);
