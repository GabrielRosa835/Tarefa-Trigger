-- CREATE DATABASE db_trigger;
USE db_trigger;

DROP TABLE tbl_filmes;
CREATE TABLE tbl_filmes (
	Filme_Id INT PRIMARY KEY AUTO_INCREMENT,
    Filme_Titulo VARCHAR(60),
    Filme_Minutos INT
);

DELIMITER $
CREATE TRIGGER tr_check_minutos
	BEFORE INSERT ON tbl_filmes
	FOR EACH ROW
	BEGIN
		IF NEW.Filme_Minutos <= 0 THEN
			SET NEW.Filme_Minutos = NULL;
            /* SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Valor inválido para minutos',
            MYSQL_ERRNO = 2022; */
		END IF;
	END $
DELIMITER ;

INSERT INTO tbl_filmes (Filme_Titulo, Filme_Minutos) VALUES
('The terrible trigger', 120),
('O alto da compadecida', 135),
('Faroeste Caboclo', 240),
('The matrix', 90),
('Blade Runner', -88),
('O labirinto do fauno', 110),
('Metrópole', 0),
('A lista', 120);

SELECT * FROM tbl_filmes;

DROP TABLE tbl_log_deletions;
CREATE TABLE tbl_log_deletions (
	Delete_Id INT PRIMARY KEY AUTO_INCREMENT,
    Delete_Titulo VARCHAR(60),
    Delete_Quando DATETIME,
    Delete_Quem VARCHAR(40)
);

DELIMITER $
CREATE TRIGGER tr_log_deletions
	AFTER DELETE ON tbl_filmes
    FOR EACH ROW
		BEGIN
			INSERT INTO tbl_log_deletions
            VALUES (NULL, OLD.Filme_Titulo, SYSDATE(), USER());
		END $
DELIMITER ;

DELETE FROM tbl_filmes WHERE Filme_Id = 2;
DELETE FROM tbl_filmes WHERE Filme_Id = 4;

SELECT * FROM tbl_log_deletions;

SELECT * FROM tbl_filmes;