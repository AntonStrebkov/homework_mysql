USE lesson_4;

/*
 * 1. Создайте представление, в которое попадет информация о пользователях
 * (имя, фамилия, город и пол), которые не старше 20 лет.
 */ 

CREATE VIEW v_info_user AS
SELECT u.firstname, u.lastname, p.hometown, p.gender
FROM users AS u
INNER JOIN profiles AS p 
ON u.id = p.user_id
WHERE (DATE_FORMAT(FROM_DAYS(DATEDIFF(now(),p.birthday)), '%Y')+0) < 20;

SELECT * FROM v_info_user;

/* 
 * 2. Найдите кол-во, отправленных сообщений каждым пользователем и выведите ранжированный список пользователь,
 * указав указать имя и фамилию пользователя, количество отправленных сообщений и место в рейтинге
 * (первое место у пользователя с максимальным количеством сообщений) . (используйте DENSE_RANK)
 */ 

SELECT 
CONCAT(u.firstname, ' ', u.lastname) AS name, 
COUNT(from_user_id) AS amount_messages,
DENSE_RANK() OVER (ORDER BY COUNT(from_user_id) DESC) AS rank_user
FROM users u 
INNER JOIN messages m ON u.id = m.from_user_id 
GROUP BY m.from_user_id
ORDER BY amount_messages DESC;
/*
 * 3. Выберите все сообщения, отсортируйте сообщения по возрастанию даты отправления (created_at)
 *  и найдите разницу дат отправления между соседними сообщениями, получившегося списка. 
 * (используйте LEAD или LAG)
*/


SELECT body, created_at,
LAG(created_at) OVER (ORDER BY created_at) AS lag_message,
-- created_at - (LAG(created_at) OVER (ORDER BY created_at)) AS difference
TIMEDIFF(created_at, LAG(created_at) OVER (ORDER BY created_at)) AS difference
FROM messages
ORDER BY created_at;
