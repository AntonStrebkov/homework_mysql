USE homework_4;

/*Подсчитать общее количество лайков, которые получили пользователи младше 12 лет.*/


SELECT COUNT(*)
FROM likes
WHERE media_id IN ( 
	SELECT id 
	FROM media 
	WHERE user_id IN ( 
		SELECT 
			user_id 
		FROM profiles AS p
		WHERE  YEAR(CURDATE()) - YEAR(birthday) <= 12
	)
);
 
/*Определить кто больше поставил лайков (всего): мужчины или женщины.*/

SELECT IF(
	(SELECT SUM(likes_num) AS m_likes
		FROM (
			SELECT user_id, COUNT(*) AS likes_num
				FROM likes
				WHERE user_id IN (
					SELECT * FROM (
						SELECT user_id
							FROM profiles
							WHERE gender = 'm'
						) AS men)
				GROUP BY user_id
			) AS men_likes)
	> 
    	(SELECT SUM(likes_num) AS f_likes
		FROM (
			SELECT user_id, COUNT(*) AS likes_num
				FROM likes
				WHERE user_id IN (
					SELECT * FROM (
						SELECT user_id
							FROM profiles
							WHERE gender = 'f'
						) AS women)
				GROUP BY user_id
			) AS women_likes)
    ,'Мужчины', 'Женщины') AS 'Кто поставил больше лайков?';

/*Вывести всех пользователей, которые не отправляли сообщения.*/

SELECT concat(firstname, ' ', lastname) AS 'Пользователь'
FROM users u 
WHERE NOT EXISTS (SELECT from_user_id FROM messages m WHERE u.id = m.from_user_id);


