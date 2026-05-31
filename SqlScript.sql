-- ============================================================
--  DB_EXPERT — Script completo
--  Incluye: BD, Tablas, Datos, Procedimientos Almacenados
--  Versión consolidada y corregida
-- ============================================================

-- ============================================================
-- 1. BASE DE DATOS
-- ============================================================
CREATE DATABASE IF NOT EXISTS DB_EXPERT;
USE DB_EXPERT;

-- ============================================================
-- 2. TABLAS
-- ============================================================
CREATE TABLE EXP_Asesorado(
    ASE_Id          INT             AUTO_INCREMENT,
    ASE_Nombre      NVARCHAR(100),
    ASE_ApellidoP   NVARCHAR(50),
    ASE_ApellidoM   NVARCHAR(50),
    ASE_Usuario     NVARCHAR(50)    UNIQUE,
    ASE_Email       NVARCHAR(50)    UNIQUE,
    ASE_Contrasenia NVARCHAR(60),
    PRIMARY KEY(ASE_Id)
);

CREATE TABLE EXP_Asesor(
    ASO_Id          INT             AUTO_INCREMENT,
    ASO_Nombre      NVARCHAR(100),
    ASO_ApellidoP   NVARCHAR(50),
    ASO_ApellidoM   NVARCHAR(50),
    ASO_Usuario     NVARCHAR(50)    UNIQUE,
    ASO_Email       NVARCHAR(50)    UNIQUE,
    ASO_Contrasenia NVARCHAR(60),
    ASO_Tarifa      FLOAT,
    PRIMARY KEY(ASO_Id)
);

CREATE TABLE EXP_Tema(
    TEM_Id          INT             AUTO_INCREMENT,
    TEM_Nombre      NVARCHAR(255),
    TEM_Complejidad INT,
    PRIMARY KEY(TEM_Id)
);

CREATE TABLE EXP_Asesoria(
    ASE_Id          INT,
    ASO_Id          INT,
    ASR_Fecha       DATETIME,
    ASR_Tema        VARCHAR(255),
    ASR_Confirmado  BOOLEAN         DEFAULT(FALSE),
    FOREIGN KEY(ASE_Id) REFERENCES EXP_Asesorado(ASE_Id),
    FOREIGN KEY(ASO_Id) REFERENCES EXP_Asesor(ASO_Id)
);

CREATE TABLE EXP_Repertorio(
    ASO_Id  INT,
    TEM_Id  INT,
    FOREIGN KEY(ASO_Id) REFERENCES EXP_Asesor(ASO_Id),
    FOREIGN KEY(TEM_Id) REFERENCES EXP_Tema(TEM_Id)
);

-- ============================================================
-- 3. INSERCIÓN DE DATOS
-- ============================================================
INSERT INTO EXP_Asesorado
    (ASE_Nombre, ASE_ApellidoP, ASE_ApellidoM, ASE_Usuario, ASE_Email, ASE_Contrasenia)
VALUES
    ('Carlos',   'Ramirez',  'Lopez',   'carlosr',  'carlosr@mail.com',  'pass123'),
    ('Ana',      'Martinez', 'Soto',    'anas',     'anas@mail.com',     'pass123'),
    ('Luis',     'Hernandez','Perez',   'luish',    'luish@mail.com',    'pass123'),
    ('Fernanda', 'Gomez',    'Ruiz',    'ferg',     'ferg@mail.com',     'pass123'),
    ('Miguel',   'Torres',   'Diaz',    'miguelt',  'miguelt@mail.com',  'pass123'),
    ('Sofia',    'Castro',   'Mendoza', 'sofiac',   'sofiac@mail.com',   'pass123'),
    ('Ricardo',  'Vega',     'Ortega',  'ricv',     'ricv@mail.com',     'pass123'),
    ('Valeria',  'Jimenez',  'Navarro', 'valej',    'valej@mail.com',    'pass123'),
    ('Daniel',   'Flores',   'Silva',   'danf',     'danf@mail.com',     'pass123'),
    ('Camila',   'Rojas',    'Nunez',   'camir',    'camir@mail.com',    'pass123'),
    ('Diego',    'Morales',  'Cruz',    'diegom',   'diegom@mail.com',   'pass123'),
    ('Paola',    'Vargas',   'Reyes',   'paov',     'paov@mail.com',     'pass123'),
    ('Jorge',    'Molina',   'Campos',  'jorgem',   'jorgem@mail.com',   'pass123'),
    ('Natalia',  'Herrera',  'Luna',    'natl',     'natl@mail.com',     'pass123'),
    ('Eduardo',  'Pineda',   'Rios',    'edup',     'edup@mail.com',     'pass123'),
    ('Lucia',    'Salazar',  'Mejia',   'lucias',   'lucias@mail.com',   'pass123'),
    ('Andres',   'Acosta',   'Fuentes', 'andresa',  'andresa@mail.com',  'pass123'),
    ('Mariana',  'Delgado',  'Ibarra',  'marid',    'marid@mail.com',    'pass123'),
    ('Ivan',     'Cortes',   'Serrano', 'ivanc',    'ivanc@mail.com',    'pass123'),
    ('Elena',    'Peña',     'Galindo', 'elenap',   'elenap@mail.com',   'pass123');

INSERT INTO EXP_Asesor
    (ASO_Nombre, ASO_ApellidoP, ASO_ApellidoM, ASO_Usuario, ASO_Email, ASO_Contrasenia, ASO_Tarifa)
VALUES
    ('Roberto',  'Garcia',   'Lopez',   'robertog',  'robertog@mail.com',  'pass123', 250),
    ('Patricia', 'Mendez',   'Soto',    'patriciam', 'patriciam@mail.com', 'pass123', 300),
    ('Alberto',  'Ruiz',     'Cano',    'albertor',  'albertor@mail.com',  'pass123', 220),
    ('Diana',    'Aguilar',  'Ramos',   'dianaa',    'dianaa@mail.com',    'pass123', 280),
    ('Oscar',    'Navarro',  'Lara',    'oscarn',    'oscarn@mail.com',    'pass123', 350),
    ('Gabriela', 'Silva',    'Mora',    'gabys',     'gabys@mail.com',     'pass123', 260),
    ('Raul',     'Campos',   'Ortiz',   'raulc',     'raulc@mail.com',     'pass123', 240),
    ('Monica',   'Leon',     'Rios',    'monical',   'monical@mail.com',   'pass123', 310),
    ('Hector',   'Fuentes',  'Diaz',    'hectorf',   'hectorf@mail.com',   'pass123', 270),
    ('Karina',   'Paz',      'Vega',    'karinap',   'karinap@mail.com',   'pass123', 290),
    ('Fernando', 'Ibarra',   'Sanchez', 'feri',      'feri@mail.com',      'pass123', 320),
    ('Alicia',   'Nava',     'Torres',  'alician',   'alician@mail.com',   'pass123', 275),
    ('Sergio',   'Valdez',   'Mejia',   'sergiov',   'sergiov@mail.com',   'pass123', 260),
    ('Beatriz',  'Roman',    'Flores',  'beatrizr',  'beatrizr@mail.com',  'pass123', 340),
    ('Arturo',   'Luna',     'Salas',   'arturol',   'arturol@mail.com',   'pass123', 295),
    ('Claudia',  'Molina',   'Perez',   'claudiam',  'claudiam@mail.com',  'pass123', 285),
    ('Victor',   'Serrano',  'Acuna',   'victors',   'victors@mail.com',   'pass123', 330),
    ('Lorena',   'Bravo',    'Jimenez', 'lorenab',   'lorenab@mail.com',   'pass123', 245),
    ('Ruben',    'Esquivel', 'Ponce',   'rubene',    'rubene@mail.com',    'pass123', 315),
    ('Sandra',   'Tapia',    'Moreno',  'sandrat',   'sandrat@mail.com',   'pass123', 300);

INSERT INTO EXP_Tema
    (TEM_Nombre, TEM_Complejidad)
VALUES
    ('Matematicas Basicas',        1),
    ('Algebra',                    2),
    ('Geometria Analitica',        3),
    ('Calculo Diferencial',        4),
    ('Calculo Integral',           5),
    ('Programacion en C',          2),
    ('Programacion en Java',       3),
    ('Base de Datos',              3),
    ('Redes de Computadoras',      4),
    ('Inteligencia Artificial',    5),
    ('Fisica Clasica',             3),
    ('Electronica Digital',        4),
    ('Estadistica',                2),
    ('Probabilidad',               3),
    ('Quimica General',            2),
    ('Quimica Organica',           4),
    ('Ingles Tecnico',             1),
    ('Desarrollo Web',             3),
    ('Arduino y Microcontroladores', 4),
    ('Machine Learning',           5);

INSERT INTO EXP_Asesoria
    (ASE_Id, ASO_Id, ASR_Fecha, ASR_Tema, ASR_Confirmado)
VALUES
    (1,  1,  '2026-05-01 10:00:00', 'Algebra',            TRUE),
    (2,  2,  '2026-05-01 11:00:00', 'Calculo Diferencial', TRUE),
    (3,  3,  '2026-05-01 12:00:00', 'Java',               FALSE),
    (4,  4,  '2026-05-02 09:00:00', 'Bases de Datos',     TRUE),
    (5,  5,  '2026-05-02 10:00:00', 'Redes',              FALSE),
    (6,  6,  '2026-05-02 11:00:00', 'Fisica',             TRUE),
    (7,  7,  '2026-05-02 12:00:00', 'Electronica',        TRUE),
    (8,  8,  '2026-05-03 09:00:00', 'Estadistica',        FALSE),
    (9,  9,  '2026-05-03 10:00:00', 'Probabilidad',       TRUE),
    (10, 10, '2026-05-03 11:00:00', 'Quimica',            TRUE),
    (11, 11, '2026-05-03 12:00:00', 'Machine Learning',   FALSE),
    (12, 12, '2026-05-04 09:00:00', 'Arduino',            TRUE),
    (13, 13, '2026-05-04 10:00:00', 'Desarrollo Web',     TRUE),
    (14, 14, '2026-05-04 11:00:00', 'Calculo Integral',   FALSE),
    (15, 15, '2026-05-04 12:00:00', 'IA',                 TRUE),
    (16, 16, '2026-05-05 09:00:00', 'Algebra',            TRUE),
    (17, 17, '2026-05-05 10:00:00', 'Java',               FALSE),
    (18, 18, '2026-05-05 11:00:00', 'Fisica',             TRUE),
    (19, 19, '2026-05-05 12:00:00', 'Quimica Organica',   TRUE),
    (20, 20, '2026-05-06 09:00:00', 'Redes',              FALSE),
    (1,  5,  '2026-05-06 10:00:00', 'Bases de Datos',     TRUE),
    (2,  6,  '2026-05-06 11:00:00', 'Arduino',            TRUE),
    (3,  7,  '2026-05-06 12:00:00', 'Electronica',        FALSE),
    (4,  8,  '2026-05-07 09:00:00', 'Estadistica',        TRUE),
    (5,  9,  '2026-05-07 10:00:00', 'Probabilidad',       TRUE),
    (6,  10, '2026-05-07 11:00:00', 'Calculo Integral',   FALSE),
    (7,  11, '2026-05-07 12:00:00', 'Machine Learning',   TRUE),
    (8,  12, '2026-05-08 09:00:00', 'Ingles Tecnico',     TRUE),
    (9,  13, '2026-05-08 10:00:00', 'Programacion C',     FALSE),
    (10, 14, '2026-05-08 11:00:00', 'Java',               TRUE),
    (11, 15, '2026-05-08 12:00:00', 'IA',                 TRUE),
    (12, 16, '2026-05-09 09:00:00', 'Desarrollo Web',     FALSE),
    (13, 17, '2026-05-09 10:00:00', 'Algebra',            TRUE),
    (14, 18, '2026-05-09 11:00:00', 'Redes',              TRUE),
    (15, 19, '2026-05-09 12:00:00', 'Fisica',             FALSE),
    (16, 20, '2026-05-10 09:00:00', 'Quimica',            TRUE),
    (17, 1,  '2026-05-10 10:00:00', 'Electronica',        TRUE),
    (18, 2,  '2026-05-10 11:00:00', 'Calculo Diferencial', FALSE),
    (19, 3,  '2026-05-10 12:00:00', 'Estadistica',        TRUE),
    (20, 4,  '2026-05-11 09:00:00', 'Programacion Java',  TRUE),
    (5,  1,  '2026-05-11 10:00:00', 'Machine Learning',   FALSE),
    (6,  2,  '2026-05-11 11:00:00', 'Arduino',            TRUE),
    (7,  3,  '2026-05-11 12:00:00', 'Desarrollo Web',     TRUE),
    (8,  4,  '2026-05-12 09:00:00', 'Probabilidad',       FALSE),
    (9,  5,  '2026-05-12 10:00:00', 'IA',                 TRUE),
    (10, 6,  '2026-05-12 11:00:00', 'Fisica',             TRUE),
    (11, 7,  '2026-05-12 12:00:00', 'Java',               FALSE),
    (12, 8,  '2026-05-13 09:00:00', 'Calculo Integral',   TRUE),
    (13, 9,  '2026-05-13 10:00:00', 'Bases de Datos',     TRUE),
    (14, 10, '2026-05-13 11:00:00', 'Electronica',        FALSE);

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

-- ============================================================
-- 4. PROCEDIMIENTOS ALMACENADOS
-- ============================================================

-- ------------------------------------------------------------
-- SP01 | tspRevisarTemas
-- Lista todos los temas disponibles en el sistema
-- Uso: CALL tspRevisarTemas()
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspRevisarTemas()
BEGIN
    SELECT
        TEM_Id          AS Id,
        TEM_Nombre      AS Nombre,
        TEM_Complejidad AS Complejidad
    FROM EXP_Tema
    ORDER BY TEM_Complejidad ASC, TEM_Nombre ASC;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP02 | tspIniciarSesion
-- Autentica a un usuario (asesorado o asesor)
-- Uso: CALL tspIniciarSesion('usuario_o_email', 'contrasenia')
-- Retorna: datos del usuario + TipoUsuario ('ASESORADO'|'ASESOR')
--          o Id=0 + Mensaje si las credenciales son incorrectas
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspIniciarSesion
(
    IN pUsuario     VARCHAR(50),
    IN pContrasenia VARCHAR(60)
)
BEGIN
    IF EXISTS (
        SELECT 1 FROM EXP_Asesorado
        WHERE (ASE_Usuario = pUsuario OR ASE_Email = pUsuario)
          AND ASE_Contrasenia = pContrasenia
    ) THEN
        SELECT
            ASE_Id          AS Id,
            ASE_Nombre      AS Nombre,
            ASE_ApellidoP   AS ApellidoPaterno,
            ASE_ApellidoM   AS ApellidoMaterno,
            ASE_Usuario     AS Usuario,
            ASE_Email       AS Email,
            'ASESORADO'     AS TipoUsuario
        FROM EXP_Asesorado
        WHERE (ASE_Usuario = pUsuario OR ASE_Email = pUsuario)
          AND ASE_Contrasenia = pContrasenia;

    ELSEIF EXISTS (
        SELECT 1 FROM EXP_Asesor
        WHERE (ASO_Usuario = pUsuario OR ASO_Email = pUsuario)
          AND ASO_Contrasenia = pContrasenia
    ) THEN
        SELECT
            ASO_Id          AS Id,
            ASO_Nombre      AS Nombre,
            ASO_ApellidoP   AS ApellidoPaterno,
            ASO_ApellidoM   AS ApellidoMaterno,
            ASO_Usuario     AS Usuario,
            ASO_Email       AS Email,
            'ASESOR'        AS TipoUsuario,
            ASO_Tarifa      AS Tarifa
        FROM EXP_Asesor
        WHERE (ASO_Usuario = pUsuario OR ASO_Email = pUsuario)
          AND ASO_Contrasenia = pContrasenia;
    ELSE
        SELECT 0 AS Id, 'Usuario o contraseña incorrectos' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP03 | tspRegistrarAsesorado  [PF01 — CORREGIDO]
-- Registra un nuevo asesorado validando formato de email
-- Uso: CALL tspRegistrarAsesorado('Nombre','ApP','ApM','usuario','email','pass')
-- Retorna: Id del nuevo registro, o Mensaje de error
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspRegistrarAsesorado
(
    IN pNombre      VARCHAR(100),
    IN pApellidoP   VARCHAR(50),
    IN pApellidoM   VARCHAR(50),
    IN pUsuario     VARCHAR(50),
    IN pEmail       VARCHAR(50),
    IN pContrasenia VARCHAR(255)
)
BEGIN
    -- PF01: Validar formato de email con dominio real
    IF pEmail NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
        SELECT 'ERROR: El correo electrónico no tiene un formato válido.' AS Mensaje;

    ELSEIF EXISTS(SELECT 1 FROM EXP_Asesorado WHERE ASE_Usuario = pUsuario) THEN
        SELECT 'ERROR: El usuario ya existe.' AS Mensaje;

    ELSEIF EXISTS(SELECT 1 FROM EXP_Asesorado WHERE ASE_Email = pEmail) THEN
        SELECT 'ERROR: El correo ya está registrado.' AS Mensaje;

    ELSE
        INSERT INTO EXP_Asesorado
            (ASE_Nombre, ASE_ApellidoP, ASE_ApellidoM, ASE_Usuario, ASE_Email, ASE_Contrasenia)
        VALUES
            (pNombre, pApellidoP, pApellidoM, pUsuario, pEmail, pContrasenia);

        SELECT LAST_INSERT_ID() AS Id;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP04 | tspRegistrarAsesor  [PF02 — CORREGIDO]
-- Registra un nuevo asesor validando formato de email
-- Nota: los temas de dominio se agregan después con tspAgregarTemaAsesor
-- Uso: CALL tspRegistrarAsesor('Nombre','ApP','ApM','usuario','email','pass', tarifa)
-- Retorna: Id del nuevo registro, o Mensaje de error
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspRegistrarAsesor
(
    IN pNombre      VARCHAR(100),
    IN pApellidoP   VARCHAR(50),
    IN pApellidoM   VARCHAR(50),
    IN pUsuario     VARCHAR(50),
    IN pEmail       VARCHAR(50),
    IN pContrasenia VARCHAR(255),
    IN pTarifa      FLOAT
)
BEGIN
    -- PF02: Validar formato de email con dominio real
    IF pEmail NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$' THEN
        SELECT 'ERROR: El correo electrónico no tiene un formato válido.' AS Mensaje;

    ELSEIF EXISTS(SELECT 1 FROM EXP_Asesor WHERE ASO_Usuario = pUsuario) THEN
        SELECT 'ERROR: El usuario ya existe.' AS Mensaje;

    ELSEIF EXISTS(SELECT 1 FROM EXP_Asesor WHERE ASO_Email = pEmail) THEN
        SELECT 'ERROR: El correo ya está registrado.' AS Mensaje;

    ELSE
        INSERT INTO EXP_Asesor
            (ASO_Nombre, ASO_ApellidoP, ASO_ApellidoM, ASO_Usuario, ASO_Email, ASO_Contrasenia, ASO_Tarifa)
        VALUES
            (pNombre, pApellidoP, pApellidoM, pUsuario, pEmail, pContrasenia, pTarifa);

        SELECT LAST_INSERT_ID() AS Id;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP05 | tspAgregarTemaAsesor  [PF02 — NUEVO]
-- Agrega un tema al repertorio de un asesor
-- Llamar una vez por tema después de tspRegistrarAsesor
-- Uso: CALL tspAgregarTemaAsesor(id_asesor, id_tema)
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspAgregarTemaAsesor
(
    IN pIdAsesor    INT,
    IN pIdTema      INT
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM EXP_Repertorio
        WHERE ASO_Id = pIdAsesor AND TEM_Id = pIdTema
    ) THEN
        INSERT INTO EXP_Repertorio (ASO_Id, TEM_Id) VALUES (pIdAsesor, pIdTema);
        SELECT 'ÉXITO: Tema agregado al repertorio.' AS Mensaje;
    ELSE
        SELECT 'INFO: El tema ya estaba en el repertorio del asesor.' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP06 | tspEditarUsuario
-- Edita los datos de perfil de un asesorado o asesor
-- Uso: CALL tspEditarUsuario(id, 'ASESORADO'|'ASESOR', usuario, nombre, apP, apM, email, pass)
-- Nota: si pContrasenia es NULL o vacío, conserva la contraseña actual
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspEditarUsuario
(
    IN pId          INT,
    IN pTipoUsuario VARCHAR(15),
    IN pUsuario     VARCHAR(50),
    IN pNombre      VARCHAR(100),
    IN pApellidoP   VARCHAR(50),
    IN pApellidoM   VARCHAR(50),
    IN pEmail       VARCHAR(50),
    IN pContrasenia VARCHAR(60)
)
BEGIN
    DECLARE vExisteUsuario INT DEFAULT 0;
    DECLARE vExisteEmail   INT DEFAULT 0;

    IF pTipoUsuario = 'ASESORADO' THEN
        SELECT COUNT(*) INTO vExisteUsuario FROM EXP_Asesorado WHERE ASE_Usuario = pUsuario AND ASE_Id != pId;
        SELECT COUNT(*) INTO vExisteEmail   FROM EXP_Asesorado WHERE ASE_Email   = pEmail   AND ASE_Id != pId;

        IF vExisteUsuario > 0 THEN
            SELECT 'ERROR: El nombre de usuario ya está en uso.' AS Mensaje;
        ELSEIF vExisteEmail > 0 THEN
            SELECT 'ERROR: El correo electrónico ya está registrado.' AS Mensaje;
        ELSE
            UPDATE EXP_Asesorado SET
                ASE_Nombre      = pNombre,
                ASE_ApellidoP   = pApellidoP,
                ASE_ApellidoM   = pApellidoM,
                ASE_Usuario     = pUsuario,
                ASE_Email       = pEmail,
                ASE_Contrasenia = IF(pContrasenia = '' OR pContrasenia IS NULL, ASE_Contrasenia, pContrasenia)
            WHERE ASE_Id = pId;
            SELECT 'ÉXITO: Perfil de Asesorado actualizado correctamente.' AS Mensaje;
        END IF;

    ELSEIF pTipoUsuario = 'ASESOR' THEN
        SELECT COUNT(*) INTO vExisteUsuario FROM EXP_Asesor WHERE ASO_Usuario = pUsuario AND ASO_Id != pId;
        SELECT COUNT(*) INTO vExisteEmail   FROM EXP_Asesor WHERE ASO_Email   = pEmail   AND ASO_Id != pId;

        IF vExisteUsuario > 0 THEN
            SELECT 'ERROR: El nombre de usuario ya está en uso.' AS Mensaje;
        ELSEIF vExisteEmail > 0 THEN
            SELECT 'ERROR: El correo electrónico ya está registrado.' AS Mensaje;
        ELSE
            UPDATE EXP_Asesor SET
                ASO_Nombre      = pNombre,
                ASO_ApellidoP   = pApellidoP,
                ASO_ApellidoM   = pApellidoM,
                ASO_Usuario     = pUsuario,
                ASO_Email       = pEmail,
                ASO_Contrasenia = IF(pContrasenia = '' OR pContrasenia IS NULL, ASO_Contrasenia, pContrasenia)
            WHERE ASO_Id = pId;
            SELECT 'ÉXITO: Perfil de Asesor actualizado correctamente.' AS Mensaje;
        END IF;
    ELSE
        SELECT 'ERROR: Tipo de usuario no válido.' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP07 | tspObtenerAsesores  [PF08 — NUEVO]
-- Lista todos los asesores disponibles con sus datos
-- Uso: CALL tspObtenerAsesores()
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspObtenerAsesores()
BEGIN
    SELECT
        ASO_Id          AS Id,
        ASO_Nombre      AS Nombre,
        ASO_ApellidoP   AS ApellidoPaterno,
        ASO_ApellidoM   AS ApellidoMaterno,
        ASO_Email       AS Email,
        ASO_Tarifa      AS Tarifa
    FROM EXP_Asesor
    ORDER BY ASO_Nombre ASC;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP08 | tspObtenerTemasPorAsesor  [PF09 — NUEVO]
-- Devuelve los temas de dominio de un asesor específico
-- Uso: CALL tspObtenerTemasPorAsesor(id_asesor)
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspObtenerTemasPorAsesor(IN pIdAsesor INT)
BEGIN
    SELECT
        t.TEM_Id            AS Id,
        t.TEM_Nombre        AS Nombre,
        t.TEM_Complejidad   AS Complejidad
    FROM EXP_Repertorio r
    INNER JOIN EXP_Tema t ON r.TEM_Id = t.TEM_Id
    WHERE r.ASO_Id = pIdAsesor
    ORDER BY t.TEM_Nombre ASC;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP09 | tspSolicitarAsesoria  [PF09 — CORREGIDO]
-- Solicita una asesoría con validaciones completas
-- Uso: CALL tspSolicitarAsesoria(id_asesorado, id_asesor, '2026-06-01 10:00:00', 'Algebra')
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspSolicitarAsesoria
(
    IN pIdAsesorado     INT,
    IN pIdAsesor        INT,
    IN pFecha           DATETIME,
    IN pTema            VARCHAR(255)
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM EXP_Asesor WHERE ASO_Id = pIdAsesor) THEN
        SELECT 'ERROR: El asesor no existe.' AS Mensaje;

    ELSEIF NOT EXISTS (SELECT 1 FROM EXP_Asesorado WHERE ASE_Id = pIdAsesorado) THEN
        SELECT 'ERROR: El asesorado no existe.' AS Mensaje;

    ELSEIF EXISTS (
        SELECT 1 FROM EXP_Asesoria
        WHERE ASE_Id = pIdAsesorado AND ASO_Id = pIdAsesor AND ASR_Fecha = pFecha
    ) THEN
        SELECT 'ERROR: Ya existe una solicitud para esa fecha con este asesor.' AS Mensaje;

    ELSE
        INSERT INTO EXP_Asesoria (ASE_Id, ASO_Id, ASR_Fecha, ASR_Tema, ASR_Confirmado)
        VALUES (pIdAsesorado, pIdAsesor, pFecha, pTema, FALSE);
        SELECT 'ÉXITO: Solicitud de asesoría registrada correctamente.' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP10 | tspObtenerSolicitudesAsesor  [PF10 — NUEVO]
-- Lista todas las solicitudes PENDIENTES de un asesor
-- Uso: CALL tspObtenerSolicitudesAsesor(id_asesor)
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspObtenerSolicitudesAsesor(IN pIdAsesor INT)
BEGIN
    SELECT
        a.ASE_Id                                            AS IdAsesorado,
        CONCAT(e.ASE_Nombre, ' ', e.ASE_ApellidoP)         AS NombreAsesorado,
        e.ASE_Email                                         AS EmailAsesorado,
        a.ASR_Fecha                                         AS Fecha,
        a.ASR_Tema                                          AS Tema
    FROM EXP_Asesoria a
    INNER JOIN EXP_Asesorado e ON a.ASE_Id = e.ASE_Id
    WHERE a.ASO_Id = pIdAsesor
      AND a.ASR_Confirmado = FALSE
    ORDER BY a.ASR_Fecha ASC;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP11 | tspConfirmarAsesoria  [PF11 — NUEVO]
-- Confirma una solicitud pendiente (cambia estado a TRUE)
-- Uso: CALL tspConfirmarAsesoria(id_asesorado, id_asesor, '2026-06-01 10:00:00')
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspConfirmarAsesoria
(
    IN pIdAsesorado     INT,
    IN pIdAsesor        INT,
    IN pFecha           DATETIME
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM EXP_Asesoria
        WHERE ASE_Id = pIdAsesorado AND ASO_Id = pIdAsesor
          AND ASR_Fecha = pFecha AND ASR_Confirmado = FALSE
    ) THEN
        SELECT 'ERROR: No se encontró la solicitud pendiente.' AS Mensaje;
    ELSE
        UPDATE EXP_Asesoria
        SET ASR_Confirmado = TRUE
        WHERE ASE_Id = pIdAsesorado AND ASO_Id = pIdAsesor AND ASR_Fecha = pFecha;
        SELECT 'ÉXITO: Asesoría confirmada.' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP12 | tspRechazarAsesoria  [PF11 — NUEVO]
-- Rechaza y elimina una solicitud pendiente
-- Uso: CALL tspRechazarAsesoria(id_asesorado, id_asesor, '2026-06-01 10:00:00')
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspRechazarAsesoria
(
    IN pIdAsesorado     INT,
    IN pIdAsesor        INT,
    IN pFecha           DATETIME
)
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM EXP_Asesoria
        WHERE ASE_Id = pIdAsesorado AND ASO_Id = pIdAsesor
          AND ASR_Fecha = pFecha AND ASR_Confirmado = FALSE
    ) THEN
        SELECT 'ERROR: No se encontró la solicitud pendiente.' AS Mensaje;
    ELSE
        DELETE FROM EXP_Asesoria
        WHERE ASE_Id = pIdAsesorado AND ASO_Id = pIdAsesor
          AND ASR_Fecha = pFecha AND ASR_Confirmado = FALSE;
        SELECT 'ÉXITO: Solicitud rechazada y eliminada.' AS Mensaje;
    END IF;
END $$
DELIMITER ;

-- ------------------------------------------------------------
-- SP13 | tspObtenerAsesoriasConfirmadas  [PF12 — NUEVO]
-- Lista asesorías confirmadas según el tipo de usuario
-- Uso: CALL tspObtenerAsesoriasConfirmadas(id, 'ASESORADO'|'ASESOR')
-- ------------------------------------------------------------
DELIMITER $$
CREATE PROCEDURE tspObtenerAsesoriasConfirmadas
(
    IN pId          INT,
    IN pTipoUsuario VARCHAR(15)
)
BEGIN
    IF pTipoUsuario = 'ASESORADO' THEN
        SELECT
            CONCAT(r.ASO_Nombre, ' ', r.ASO_ApellidoP)     AS NombreAsesor,
            r.ASO_Email                                     AS EmailAsesor,
            r.ASO_Tarifa                                    AS Tarifa,
            a.ASR_Fecha                                     AS Fecha,
            a.ASR_Tema                                      AS Tema
        FROM EXP_Asesoria a
        INNER JOIN EXP_Asesor r ON a.ASO_Id = r.ASO_Id
        WHERE a.ASE_Id = pId AND a.ASR_Confirmado = TRUE
        ORDER BY a.ASR_Fecha DESC;

    ELSEIF pTipoUsuario = 'ASESOR' THEN
        SELECT
            CONCAT(e.ASE_Nombre, ' ', e.ASE_ApellidoP)     AS NombreAsesorado,
            e.ASE_Email                                     AS EmailAsesorado,
            a.ASR_Fecha                                     AS Fecha,
            a.ASR_Tema                                      AS Tema
        FROM EXP_Asesoria a
        INNER JOIN EXP_Asesorado e ON a.ASE_Id = e.ASE_Id
        WHERE a.ASO_Id = pId AND a.ASR_Confirmado = TRUE
        ORDER BY a.ASR_Fecha DESC;
    ELSE
        SELECT 'ERROR: Tipo de usuario no válido.' AS Mensaje;
    END IF;
END $$
DELIMITER ;
