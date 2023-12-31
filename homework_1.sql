/*
Создайте таблицу с мобильными телефонами (mobile_phones),
используя графический интерфейс. Заполните БД данными. Добавьте
скриншот на платформу в качестве ответа на ДЗ 
*/

-- Создаем базу данных
DROP DATABASE IF EXISTS homework_1; -- просто с первого раза не запустилось как нужно, пришлось воспользоваться)
CREATE DATABASE homework_1;
USE homework_1;

-- Создаем таблицу
CREATE TABLE mobile_phones(
id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
product_name VARCHAR(45) NOT NULL,
manufacturer VARCHAR(45) NOT NULL,
product_count SMALLINT UNSIGNED,
price INT UNSIGNED
);

-- Заполняем таблицу
INSERT INTO mobile_phones (product_name, manufacturer, product_count, price)
VALUES
("iPhone X", "Apple", 3, 76000),
("iPhone 8", "Apple", 2, 51000),
("Galaxy S9", "Samsung", 2, 56000),
("Galaxy S8", "Samsung", 1, 41000),
("P20 Pro", "Huawei", 5, 36000);

/*
Выведите название, производителя и цену для товаров, количество
которых превышает 2
*/

SELECT product_name, manufacturer, price FROM mobile_phones WHERE product_count > 2;

/*
Выведите весь ассортимент товаров марки “Samsung”
*/

SELECT product_name, product_count, price FROM mobile_phones WHERE manufacturer = "Samsung";

/*
С помощью регулярных выражений найти:
4.1. Товары, в которых есть упоминание "Iphone"
4.2. Товары, в которых есть упоминание "Samsung"
4.3. Товары, в которых есть ЦИФРЫ
4.4. Товары, в которых есть ЦИФРА "8" 
*/

SELECT product_name, manufacturer, product_count, price FROM mobile_phones WHERE product_name LIKE "Iphone%";
SELECT product_name, manufacturer, product_count, price FROM mobile_phones WHERE product_name LIKE "Samsung%";
SELECT product_name, manufacturer, product_count, price FROM mobile_phones WHERE product_name RLIKE "[0-9]";
SELECT product_name, manufacturer, product_count, price FROM mobile_phones WHERE product_name LIKE "%8";

-- Вывод всей таблицы
SELECT product_name, manufacturer, product_count, price FROM mobile_phones;



