-- Создание базы данных
DROP DATABASE IF EXISTS homework_2;
CREATE DATABASE homework_2;
USE homework_2;

-- Создание таблицы
DROP TABLE IF EXISTS sales;
CREATE TABLE sales (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	order_date DATE NOT NULL,
	count_product INT UNSIGNED NOT NULL
);

-- Заполнение таблицы
INSERT INTO sales (order_date, count_product)
VALUES ("2022.01.01", 156),
("2022.01.02", 180),
("2022.01.03", 21),
("2022.01.04", 124),
("2022.01.05", 341);

/*
 Для данных таблицы “sales” укажите тип
заказа в зависимости от кол-ва :
меньше 100 - Маленький заказ
от 100 до 300 - Средний заказ
больше 300 - Большой заказ
 */

SELECT
	id AS 'id заказа',
-- 	count_product AS 'Тип заказа',
	CASE 
		WHEN count_product < 100 THEN 'Маленький заказ'
		WHEN count_product BETWEEN 100 AND 300 THEN 'Средний заказ'
		WHEN count_product > 300 THEN 'Большой заказ'
	END AS 'Тип заказа'
FROM sales;
	
/*
 Создайте таблицу “orders”, заполните ее значениями
 */

DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT UNIQUE PRIMARY KEY,
	employee_id VARCHAR(10) NOT NULL,
	amount DECIMAL(7, 2) NOT NULL,
	order_status VARCHAR(10) NOT NULL
);

INSERT INTO orders (employee_id, amount, order_status)
VALUES 
	('e03', 15.00, 'OPEN'),
	('e01', 25.50, 'OPEN'),
	('e05', 100.70, 'CLOSED'),
	('e02',22.18, 'OPEN'),
	('e04', 9.50, 'CANCELLED');

/*
 Выберите все заказы. В зависимости от поля order_status выведите столбец full_order_status:
OPEN – «Order is in open state» ; CLOSED - «Order is closed»; CANCELLED - «Order is cancelled»
 */

SELECT 
	employee_id,
	amount,
	CASE 
		WHEN order_status = 'OPEN' THEN 'Order is in open state'
		WHEN order_status = 'CLOSED' THEN 'Order is closed'
		WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
	END AS full_order_status
FROM orders;
	


