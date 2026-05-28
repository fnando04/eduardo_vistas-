/* BASE DE DATOS */
CREATE DATABASE DB_EXPERT;
USE DB_EXPERT;

/* TABLAS */
CREATE TABLE EXP_Asesorado(
	ASE_Id				INT					AUTO_INCREMENT,
    ASE_Nombre			NVARCHAR(100), 
    ASE_ApellidoP		NVARCHAR(50),
    ASE_ApellidoM		NVARCHAR(50),
    ASE_Usuario			NVARCHAR(50)		UNIQUE,
    ASE_Email			NVARCHAR(50)		UNIQUE,
    ASE_Contrasenia		NVARCHAR(60),
    
    PRIMARY KEY(ASE_Id)
);

CREATE TABLE EXP_Asesor(
	ASO_Id				INT					AUTO_INCREMENT,
    ASO_Nombre			NVARCHAR(100), 
    ASO_ApellidoP		NVARCHAR(50),
    ASO_ApellidoM		NVARCHAR(50),
    ASO_Usuario			NVARCHAR(50)		UNIQUE,
    ASO_Email			NVARCHAR(50)		UNIQUE,
    ASO_Contrasenia		NVARCHAR(60),
    ASO_Tarifa			FLOAT,
    
    PRIMARY KEY(ASO_Id)
);

CREATE TABLE EXP_Tema(
	TEM_Id				INT					AUTO_INCREMENT,
    TEM_Nombre			NVARCHAR(255),
    TEM_Complejidad		INT,
    
    PRIMARY KEY(TEM_Id)
);

CREATE TABLE EXP_Asesoria(
	ASE_Id				INT,
    ASO_Id				INT,
    ASR_Fecha			DATETIME,
    ASR_Tema			VARCHAR(255),
    ASR_Confirmado		BOOLEAN DEFAULT(FALSE),
    
    FOREIGN KEY(ASE_Id) REFERENCES EXP_Asesorado(ASE_Id),
    FOREIGN KEY(ASO_Id) REFERENCES EXP_Asesor(ASO_Id)
);

CREATE TABLE EXP_Repertorio(
	ASO_Id				INT,
    TEM_Id				INT,
    
    FOREIGN KEY(ASO_Id) REFERENCES EXP_Asesor(ASO_Id),
    FOREIGN KEY(TEM_Id) REFERENCES EXP_Tema(TEM_Id)
);

/* INSERCIÓN DE DATOS */
INSERT INTO EXP_Asesorado
(ASE_Nombre, ASE_ApellidoP, ASE_ApellidoM, ASE_Usuario, ASE_Email, ASE_Contrasenia)
VALUES
('Carlos', 'Ramirez', 'Lopez', 'carlosr', 'carlosr@mail.com', 'pass123'),
('Ana', 'Martinez', 'Soto', 'anas', 'anas@mail.com', 'pass123'),
('Luis', 'Hernandez', 'Perez', 'luish', 'luish@mail.com', 'pass123'),
('Fernanda', 'Gomez', 'Ruiz', 'ferg', 'ferg@mail.com', 'pass123'),
('Miguel', 'Torres', 'Diaz', 'miguelt', 'miguelt@mail.com', 'pass123'),
('Sofia', 'Castro', 'Mendoza', 'sofiac', 'sofiac@mail.com', 'pass123'),
('Ricardo', 'Vega', 'Ortega', 'ricv', 'ricv@mail.com', 'pass123'),
('Valeria', 'Jimenez', 'Navarro', 'valej', 'valej@mail.com', 'pass123'),
('Daniel', 'Flores', 'Silva', 'danf', 'danf@mail.com', 'pass123'),
('Camila', 'Rojas', 'Nunez', 'camir', 'camir@mail.com', 'pass123'),
('Diego', 'Morales', 'Cruz', 'diegom', 'diegom@mail.com', 'pass123'),
('Paola', 'Vargas', 'Reyes', 'paov', 'paov@mail.com', 'pass123'),
('Jorge', 'Molina', 'Campos', 'jorgem', 'jorgem@mail.com', 'pass123'),
('Natalia', 'Herrera', 'Luna', 'natl', 'natl@mail.com', 'pass123'),
('Eduardo', 'Pineda', 'Rios', 'edup', 'edup@mail.com', 'pass123'),
('Lucia', 'Salazar', 'Mejia', 'lucias', 'lucias@mail.com', 'pass123'),
('Andres', 'Acosta', 'Fuentes', 'andresa', 'andresa@mail.com', 'pass123'),
('Mariana', 'Delgado', 'Ibarra', 'marid', 'marid@mail.com', 'pass123'),
('Ivan', 'Cortes', 'Serrano', 'ivanc', 'ivanc@mail.com', 'pass123'),
('Elena', 'Peña', 'Galindo', 'elenap', 'elenap@mail.com', 'pass123');

INSERT INTO EXP_Asesor
(ASO_Nombre, ASO_ApellidoP, ASO_ApellidoM, ASO_Usuario, ASO_Email, ASO_Contrasenia, ASO_Tarifa)
VALUES
('Roberto', 'Garcia', 'Lopez', 'robertog', 'robertog@mail.com', 'pass123', 250),
('Patricia', 'Mendez', 'Soto', 'patriciam', 'patriciam@mail.com', 'pass123', 300),
('Alberto', 'Ruiz', 'Cano', 'albertor', 'albertor@mail.com', 'pass123', 220),
('Diana', 'Aguilar', 'Ramos', 'dianaa', 'dianaa@mail.com', 'pass123', 280),
('Oscar', 'Navarro', 'Lara', 'oscarn', 'oscarn@mail.com', 'pass123', 350),
('Gabriela', 'Silva', 'Mora', 'gabys', 'gabys@mail.com', 'pass123', 260),
('Raul', 'Campos', 'Ortiz', 'raulc', 'raulc@mail.com', 'pass123', 240),
('Monica', 'Leon', 'Rios', 'monical', 'monical@mail.com', 'pass123', 310),
('Hector', 'Fuentes', 'Diaz', 'hectorf', 'hectorf@mail.com', 'pass123', 270),
('Karina', 'Paz', 'Vega', 'karinap', 'karinap@mail.com', 'pass123', 290),
('Fernando', 'Ibarra', 'Sanchez', 'feri', 'feri@mail.com', 'pass123', 320),
('Alicia', 'Nava', 'Torres', 'alician', 'alician@mail.com', 'pass123', 275),
('Sergio', 'Valdez', 'Mejia', 'sergiov', 'sergiov@mail.com', 'pass123', 260),
('Beatriz', 'Roman', 'Flores', 'beatrizr', 'beatrizr@mail.com', 'pass123', 340),
('Arturo', 'Luna', 'Salas', 'arturol', 'arturol@mail.com', 'pass123', 295),
('Claudia', 'Molina', 'Perez', 'claudiam', 'claudiam@mail.com', 'pass123', 285),
('Victor', 'Serrano', 'Acuna', 'victors', 'victors@mail.com', 'pass123', 330),
('Lorena', 'Bravo', 'Jimenez', 'lorenab', 'lorenab@mail.com', 'pass123', 245),
('Ruben', 'Esquivel', 'Ponce', 'rubene', 'rubene@mail.com', 'pass123', 315),
('Sandra', 'Tapia', 'Moreno', 'sandrat', 'sandrat@mail.com', 'pass123', 300);

INSERT INTO EXP_Tema
(TEM_Nombre, TEM_Complejidad)
VALUES
('Matematicas Basicas', 1),
('Algebra', 2),
('Geometria Analitica', 3),
('Calculo Diferencial', 4),
('Calculo Integral', 5),
('Programacion en C', 2),
('Programacion en Java', 3),
('Base de Datos', 3),
('Redes de Computadoras', 4),
('Inteligencia Artificial', 5),
('Fisica Clasica', 3),
('Electronica Digital', 4),
('Estadistica', 2),
('Probabilidad', 3),
('Quimica General', 2),
('Quimica Organica', 4),
('Ingles Tecnico', 1),
('Desarrollo Web', 3),
('Arduino y Microcontroladores', 4),
('Machine Learning', 5);

INSERT INTO EXP_Asesoria
(ASE_Id, ASO_Id, ASR_Fecha, ASR_Tema, ASR_Confirmado)
VALUES
(1,1,'2026-05-01 10:00:00','Algebra',TRUE),
(2,2,'2026-05-01 11:00:00','Calculo Diferencial',TRUE),
(3,3,'2026-05-01 12:00:00','Java',FALSE),
(4,4,'2026-05-02 09:00:00','Bases de Datos',TRUE),
(5,5,'2026-05-02 10:00:00','Redes',FALSE),
(6,6,'2026-05-02 11:00:00','Fisica',TRUE),
(7,7,'2026-05-02 12:00:00','Electronica',TRUE),
(8,8,'2026-05-03 09:00:00','Estadistica',FALSE),
(9,9,'2026-05-03 10:00:00','Probabilidad',TRUE),
(10,10,'2026-05-03 11:00:00','Quimica',TRUE),
(11,11,'2026-05-03 12:00:00','Machine Learning',FALSE),
(12,12,'2026-05-04 09:00:00','Arduino',TRUE),
(13,13,'2026-05-04 10:00:00','Desarrollo Web',TRUE),
(14,14,'2026-05-04 11:00:00','Calculo Integral',FALSE),
(15,15,'2026-05-04 12:00:00','IA',TRUE),
(16,16,'2026-05-05 09:00:00','Algebra',TRUE),
(17,17,'2026-05-05 10:00:00','Java',FALSE),
(18,18,'2026-05-05 11:00:00','Fisica',TRUE),
(19,19,'2026-05-05 12:00:00','Quimica Organica',TRUE),
(20,20,'2026-05-06 09:00:00','Redes',FALSE),
(1,5,'2026-05-06 10:00:00','Bases de Datos',TRUE),
(2,6,'2026-05-06 11:00:00','Arduino',TRUE),
(3,7,'2026-05-06 12:00:00','Electronica',FALSE),
(4,8,'2026-05-07 09:00:00','Estadistica',TRUE),
(5,9,'2026-05-07 10:00:00','Probabilidad',TRUE),
(6,10,'2026-05-07 11:00:00','Calculo Integral',FALSE),
(7,11,'2026-05-07 12:00:00','Machine Learning',TRUE),
(8,12,'2026-05-08 09:00:00','Ingles Tecnico',TRUE),
(9,13,'2026-05-08 10:00:00','Programacion C',FALSE),
(10,14,'2026-05-08 11:00:00','Java',TRUE),
(11,15,'2026-05-08 12:00:00','IA',TRUE),
(12,16,'2026-05-09 09:00:00','Desarrollo Web',FALSE),
(13,17,'2026-05-09 10:00:00','Algebra',TRUE),
(14,18,'2026-05-09 11:00:00','Redes',TRUE),
(15,19,'2026-05-09 12:00:00','Fisica',FALSE),
(16,20,'2026-05-10 09:00:00','Quimica',TRUE),
(17,1,'2026-05-10 10:00:00','Electronica',TRUE),
(18,2,'2026-05-10 11:00:00','Calculo Diferencial',FALSE),
(19,3,'2026-05-10 12:00:00','Estadistica',TRUE),
(20,4,'2026-05-11 09:00:00','Programacion Java',TRUE),
(5,1,'2026-05-11 10:00:00','Machine Learning',FALSE),
(6,2,'2026-05-11 11:00:00','Arduino',TRUE),
(7,3,'2026-05-11 12:00:00','Desarrollo Web',TRUE),
(8,4,'2026-05-12 09:00:00','Probabilidad',FALSE),
(9,5,'2026-05-12 10:00:00','IA',TRUE),
(10,6,'2026-05-12 11:00:00','Fisica',TRUE),
(11,7,'2026-05-12 12:00:00','Java',FALSE),
(12,8,'2026-05-13 09:00:00','Calculo Integral',TRUE),
(13,9,'2026-05-13 10:00:00','Bases de Datos',TRUE),
(14,10,'2026-05-13 11:00:00','Electronica',FALSE);

INSERT INTO EXP_Repertorio
(ASO_Id, TEM_Id)
VALUES
(1,1),(1,2),(1,3),
(2,4),(2,5),(2,6),
(3,7),(3,8),(3,9),
(4,10),(4,11),(4,12),
(5,13),(5,14),(5,15),
(6,16),(6,17),(6,18),
(7,19),(7,20),

(8,1),(8,5),(8,9),
(9,2),(9,6),(9,10),
(10,3),(10,7),(10,11),
(11,4),(11,8),(11,12),
(12,13),(12,17),(12,19),
(13,14),(13,18),(13,20),
(14,15),(14,16),(14,1),
(15,2),(15,3),(15,4),

(16,5),(16,6),
(17,7),(17,8),
(18,9),(18,10),
(19,11),(19,12),
(20,13),(20,14);

/* PROCEDIMIENTOS ALMACENADOS */
DELIMITER $$
CREATE PROCEDURE tspRevisarTemas()
BEGIN
	SELECT * FROM EXP_Tema;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE tspSolicitarAsesoria
(
    IdAsesorado			INT,
    IdAsesor			INT,
    Fecha				DATETIME,
    Tema				VARCHAR(255)
)
BEGIN
	INSERT INTO EXP_Asesoria VALUES(IdAsesorado, IdAsesor, Fecha, Tema, 0);
    
    SELECT Tema;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE tspIniciarSesion
(
    IN pUsuario VARCHAR(50),
    IN pContrasenia VARCHAR(60)
)
BEGIN
    -- Buscar en asesorados
    IF EXISTS (
        SELECT 1
        FROM EXP_Asesorado
        WHERE (ASE_Usuario = pUsuario OR ASE_Email = pUsuario)
        AND ASE_Contrasenia = pContrasenia
    ) THEN
        SELECT
            ASE_Id AS Id,
            ASE_Nombre AS Nombre,
            ASE_ApellidoP AS ApellidoPaterno,
            ASE_ApellidoM AS ApellidoMaterno,
            ASE_Usuario AS Usuario,
            ASE_Email AS Email,
            'ASESORADO' AS TipoUsuario
        FROM EXP_Asesorado
        WHERE (ASE_Usuario = pUsuario OR ASE_Email = pUsuario)
        AND ASE_Contrasenia = pContrasenia;

    -- Buscar en asesores
    ELSEIF EXISTS (
        SELECT 1
        FROM EXP_Asesor
        WHERE (ASO_Usuario = pUsuario OR ASO_Email = pUsuario)
        AND ASO_Contrasenia = pContrasenia
    ) THEN
        SELECT
            ASO_Id AS Id,
            ASO_Nombre AS Nombre,
            ASO_ApellidoP AS ApellidoPaterno,
            ASO_ApellidoM AS ApellidoMaterno,
            ASO_Usuario AS Usuario,
            ASO_Email AS Email,
            ASO_Tarifa AS Tarifa,
            'ASESOR' AS TipoUsuario
        FROM EXP_Asesor
        WHERE (ASO_Usuario = pUsuario OR ASO_Email = pUsuario)
        AND ASO_Contrasenia = pContrasenia;
    ELSE
        SELECT
            0 AS Id,
            'Usuario o contraseña incorrectos' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- PROCEDIMIENTO PARA REGISTRAR ASESORADO -- 
DELIMITER $$
CREATE PROCEDURE tspRegistrarAsesorado
(
    IN pNombre VARCHAR(100),
    IN pApellidoP VARCHAR(50),
    IN pApellidoM VARCHAR(50),
    IN pUsuario VARCHAR(50),
    IN pEmail VARCHAR(50),
    IN pContrasenia VARCHAR(255)
)
BEGIN
    -- Verificar si el usuario ya existe
    IF EXISTS(
        SELECT 1
        FROM EXP_Asesorado
        WHERE ASE_Usuario = pUsuario
    ) THEN

        SELECT 'El usuario ya existe' AS Mensaje;

    -- Verificar si el correo ya existe
    ELSEIF EXISTS(
        SELECT 1
        FROM EXP_Asesorado
        WHERE ASE_Email = pEmail
    ) THEN

        SELECT 'El correo ya está registrado' AS Mensaje;
    ELSE
        INSERT INTO EXP_Asesorado
        (
            ASE_Nombre,
            ASE_ApellidoP,
            ASE_ApellidoM,
            ASE_Usuario,
            ASE_Email,
            ASE_Contrasenia
        )
        VALUES
        (
            pNombre,
            pApellidoP,
            pApellidoM,
            pUsuario,
            pEmail,
            pContrasenia
        );

        -- Devuelve el ID del nuevo usuario
        SELECT MAX(ASE_ID) FROM EXP_Asesorado;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE tspRegistrarAsesor
(
    IN pNombre VARCHAR(100),
    IN pApellidoP VARCHAR(50),
    IN pApellidoM VARCHAR(50),
    IN pUsuario VARCHAR(50),
    IN pEmail VARCHAR(50),
    IN pContrasenia VARCHAR(255),
    IN pTarifa		FLOAT
)
BEGIN
    -- Verificar si el usuario ya existe
    IF EXISTS(
        SELECT 1
        FROM EXP_Asesor
        WHERE ASO_Usuario = pUsuario
    ) THEN

        SELECT 'El usuario ya existe' AS Mensaje;

    -- Verificar si el correo ya existe
    ELSEIF EXISTS(
        SELECT 1
        FROM EXP_Asesor
        WHERE ASO_Email = pEmail
    ) THEN

        SELECT 'El correo ya está registrado' AS Mensaje;
    ELSE
        INSERT INTO EXP_Asesor
        (
            ASO_Nombre,
            ASO_ApellidoP,
            ASO_ApellidoM,
            ASO_Usuario,
            ASO_Email,
            ASO_Contrasenia,
            ASO_Tarifa
        )
        VALUES
        (
            pNombre,
            pApellidoP,
            pApellidoM,
            pUsuario,
            pEmail,
            pContrasenia,
            pTarifa
        );

		-- Devuelve el ID del nuevo usuario
        SELECT MAX(ASO_ID) FROM EXP_Asesor;
    END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE tspEditarUsuario
(
    IN pId          INT,          -- ID del usuario que está logueado
    IN pTipoUsuario VARCHAR(15),  -- 'ASESORADO' o 'ASESOR'
    IN pUsuario     VARCHAR(50),  -- Input: Cambiar Usuario
    IN pNombre      VARCHAR(100), -- Input: Nombre(s)
    IN pApellidoP   VARCHAR(50),  -- Input: Apellido Paterno
    IN pApellidoM   VARCHAR(50),  -- Input: Apellido Materno
    IN pEmail       VARCHAR(50),  -- Input: Cambiar Correo Electrónico
    IN pContrasenia VARCHAR(60)   -- Input: Cambiar Contraseña
)
BEGIN
    -- Declarar variables para validaciones de duplicados
    DECLARE vExisteUsuario INT DEFAULT 0;
    DECLARE vExisteEmail INT DEFAULT 0;

    -- 1. VALIDACIONES PARA ASESORADO
    IF pTipoUsuario = 'ASESORADO' THEN
        -- Validar si el nuevo nombre de usuario ya existe en otro registro diferente al suyo
        SELECT COUNT(*) INTO vExisteUsuario FROM EXP_Asesorado WHERE ASE_Usuario = pUsuario AND ASE_Id != pId;
        -- Validar si el nuevo correo ya existe en otro registro diferente al suyo
        SELECT COUNT(*) INTO vExisteEmail FROM EXP_Asesorado WHERE ASE_Email = pEmail AND ASE_Id != pId;

        IF vExisteUsuario > 0 THEN
            SELECT 'ERROR: El nombre de usuario ya está en uso.' AS Mensaje;
        ELSEIF vExisteEmail > 0 THEN
            SELECT 'ERROR: El correo electrónico ya está registrado.' AS Mensaje;
        ELSE
            -- Ejecutar la actualización en la tabla de asesorados
            UPDATE EXP_Asesorado
            SET 
                ASE_Nombre = pNombre,
                ASE_ApellidoP = pApellidoP,
                ASE_ApellidoM = pApellidoM,
                ASE_Usuario = pUsuario,
                ASE_Email = pEmail,
                ASE_Contrasenia = IF(pContrasenia = '' OR pContrasenia IS NULL, ASE_Contrasenia, pContrasenia)
            WHERE ASE_Id = pId;

            SELECT 'ÉXITO: Perfil de Asesorado actualizado correctamente.' AS Mensaje;
        END IF;

    -- 2. VALIDACIONES PARA ASESOR
    ELSEIF pTipoUsuario = 'ASESOR' THEN
        -- Validar duplicados en la tabla de asesores
        SELECT COUNT(*) INTO vExisteUsuario FROM EXP_Asesor WHERE ASO_Usuario = pUsuario AND ASO_Id != pId;
        SELECT COUNT(*) INTO vExisteEmail FROM EXP_Asesor WHERE ASO_Email = pEmail AND ASO_Id != pId;

        IF vExisteUsuario > 0 THEN
            SELECT 'ERROR: El nombre de usuario ya está en uso.' AS Mensaje;
        ELSEIF vExisteEmail > 0 THEN
            SELECT 'ERROR: El correo electrónico ya está registrado.' AS Mensaje;
        ELSE
            -- Ejecutar la actualización en la tabla de asesores
            UPDATE EXP_Asesor
            SET 
                ASO_Nombre = pNombre,
                ASO_ApellidoP = pApellidoP,
                ASO_ApellidoM = pApellidoM,
                ASO_Usuario = pUsuario,
                ASO_Email = pEmail,
                ASO_Contrasenia = IF(pContrasenia = '' OR pContrasenia IS NULL, ASO_Contrasenia, pContrasenia)
            WHERE ASO_Id = pId;

            SELECT 'ÉXITO: Perfil de Asesorado actualizado correctamente.' AS Mensaje;
        END IF;
    ELSE
        SELECT 'ERROR: Tipo de usuario no válido.' AS Mensaje;
    END IF;
END $$
DELIMITER ;