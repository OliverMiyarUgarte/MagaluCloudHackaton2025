CREATE DATABASE IF NOT EXISTS sistema_dragao;
USE sistema_dragao;

-- ========================
-- Tabelas Primárias
-- ========================

CREATE TABLE User (
    ID_user INT AUTO_INCREMENT PRIMARY KEY,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Name VARCHAR(100) NOT NULL,
    Senha VARCHAR(255) NOT NULL
);

CREATE TABLE Grupo (
    ID_grupo INT AUTO_INCREMENT PRIMARY KEY,
    Nuser INT NOT NULL,
    Name VARCHAR(100) NOT NULL
);

CREATE TABLE Dragao (
    ID_dragao INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Nivel INT NOT NULL,
    Cor VARCHAR(50),
    Tipo VARCHAR(50),
    Poder INT NOT NULL
);

-- ========================
-- Tabelas Relacionais
-- ========================

CREATE TABLE TUD (
    ID_user INT NOT NULL,
    ID_dragao INT NOT NULL,
    PRIMARY KEY (ID_user, ID_dragao),
    FOREIGN KEY (ID_user) REFERENCES User(ID_user) ON DELETE CASCADE,
    FOREIGN KEY (ID_dragao) REFERENCES Dragao(ID_dragao) ON DELETE CASCADE
);

CREATE TABLE TUG (
    ID_user INT NOT NULL,
    ID_grupo INT NOT NULL,
    PRIMARY KEY (ID_user, ID_grupo),
    FOREIGN KEY (ID_user) REFERENCES User(ID_user) ON DELETE CASCADE,
    FOREIGN KEY (ID_grupo) REFERENCES Grupo(ID_grupo) ON DELETE CASCADE
);

-- ========================
-- Triggers para cardinalidade mínima
-- ========================

DELIMITER //

-- Dragão deve ter pelo menos 1 usuário
CREATE TRIGGER trg_dragao_usuario
BEFORE DELETE ON TUD
FOR EACH ROW
BEGIN
    DECLARE qtd INT;
    SELECT COUNT(*) INTO qtd
    FROM TUD
    WHERE ID_dragao = OLD.ID_dragao;
    IF qtd <= 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Um dragão deve pertencer a pelo menos um usuário';
    END IF;
END//

-- Grupo deve ter pelo menos 1 usuário
CREATE TRIGGER trg_grupo_usuario
BEFORE DELETE ON TUG
FOR EACH ROW
BEGIN
    DECLARE qtd INT;
    SELECT COUNT(*) INTO qtd
    FROM TUG
    WHERE ID_grupo = OLD.ID_grupo;
    IF qtd <= 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Um grupo deve ter pelo menos um usuário';
    END IF;
END//

DELIMITER ;
