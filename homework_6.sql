USE lesson_4;

/*
 * Создайте таблицу users_old, аналогичную таблице users. 
 * Создайте процедуру, с помощью которой можно переместить любого (одного)
 * пользователя из таблицы users в таблицу users_old. 
 * (использование транзакции с выбором commit или rollback – обязательно).
 */

DROP TABLE IF EXISTS users_old;
CREATE TABLE users_old (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL UNIQUE,
	firstname VARCHAR(50) DEFAULT NULL,
	lastname VARCHAR(50) DEFAULT NULL,
	email VARCHAR(50) DEFAULT NULL UNIQUE);


	
DROP PROCEDURE IF EXISTS copy_user;
DELIMITER //
CREATE PROCEDURE copy_user()
BEGIN
	DECLARE `_rollback` BIT DEFAULT b'0';
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
	BEGIN 
		SET `_rollback` = b'1';
	END;

START TRANSACTION;

INSERT INTO users_old SELECT * FROM users WHERE id = 1;
DELETE FROM users WHERE id = 1 LIMIT 1;

	IF `_rollback` THEN
		ROLLBACK;
	ELSE 
		COMMIT;
	END IF;

END //
DELIMITER ;

CALL copy_user; 



/*
 * Создайте хранимую функцию hello(), которая будет возвращать приветствие,
 * в зависимости от текущего времени суток. 
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", 
 * с 18:00 до 00:00 — "Добрый вечер", 
 * с 00:00 до 6:00 — "Доброй ночи".
 */

DROP FUNCTION IF EXISTS hello;
DELIMITER //
CREATE FUNCTION hello()
RETURNS TINYTEXT DETERMINISTIC
BEGIN
-- DECLARE time_now INT;
-- SET time_now = CURRENT_TIME();
	CASE
		WHEN CURRENT_TIME() BETWEEN '06:00:00' AND '11:59:59'
		THEN RETURN 'Доброе утро';
		WHEN CURRENT_TIME() BETWEEN '12:00:00' AND '17:59:59'
		THEN RETURN 'Добрый день';
		WHEN CURRENT_TIME() BETWEEN '18:00:00' AND '23:59:59'
		THEN RETURN 'Добрый вечер';
		WHEN CURRENT_TIME() BETWEEN '00:00:00' AND '05:59:59'
		THEN RETURN 'Доброе утро';
	END CASE;
END//
DELIMITER ;

SELECT hello() AS Приветствие;

/*
 * (по желанию)* Создайте таблицу logs типа Archive. 
 * Пусть при каждом создании записи в таблицах users, 
 * communities и messages в таблицу logs помещается время и 
 * дата создания записи, название таблицы, идентификатор первичного ключа.
 */

