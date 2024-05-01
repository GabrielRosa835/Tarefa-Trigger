-- CREATE DATABASE db_trigger;
USE db_trigger;

DROP TABLE tbl_pedidos;
CREATE TABLE tbl_pedidos(
	Pedido_Id INT PRIMARY KEY AUTO_INCREMENT,
    Pedido_Data DATE,
    Cliente_Nome VARCHAR(100)
);

INSERT INTO tbl_pedidos (Pedido_Data, Cliente_Nome) VALUES
(NOW(), '[Cliente 1]'),
(NOW(), '[Cliente 2]'),
(NOW(), '[Cliente 3]');

SELECT * FROM tbl_pedidos;

DELIMITER $
CREATE TRIGGER tr_data_criacao_pedido
	BEFORE INSERT ON tbl_pedidos
	FOR EACH ROW
	BEGIN
		SET NEW.Pedido_Data = NOW();
	END $
DELIMITER ;

INSERT INTO tbl_pedidos (Cliente_Nome) VALUES
('[Cliente 4]'),
('[Cliente 5]'),
('[Cliente 6]');

SELECT * FROM tbl_pedidos;