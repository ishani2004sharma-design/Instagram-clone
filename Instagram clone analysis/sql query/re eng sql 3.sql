		/*Ques.1 The first 10 users on the platform*/
SELECT * FROM ig_clone.users
ORDER BY created_at asc limit 10;


		/*Ques.2 Total number of registrations*/
SELECT COUNT(*) AS 'Total registration'
from ig_clone.users; 

		/*Ques.3 The day of the week most users register on*/
SELECT DAYNAME (created_at) AS 'Day of the week',
COUNT(*) AS 'Users_Registered'
FROM ig_clone.users
GROUP BY DAYNAME(created_at)
ORDER BY Users_Registered desc;

		/*Ques.4 The users who have never posted a photo*/
SELECT u.username 
FROM ig_clone.users u
LEFT JOIN ig_clone.photos p on p.user_id = u.id
WHERE p.id is NULL;
/* here left join used to combine both user and photo table and compare the id's which have posted photo or which don't*/

			/*Ques.5 The most likes on a single photo*/
SELECT u.username , p.image_url, COUNT(*) AS Total 
FROM  ig_clone.photos p
INNER JOIN  
ig_clone.likes l ON l.photo_id = p.id
INNER JOIN
ig_clone.users u ON p.user_id = u.id
GROUP BY p.id
ORDER BY total DESC
limit 1;

			/*Ques.6 The number of photos posted by most active users*/
SELECT u.username AS 'Username',
COUNT(p.image_url) AS 'Number of Posts'
FROM ig_clone.users u
JOIN 
ig_clone.photos p ON u.id = p.user_id
GROUP BY u.id
ORDER BY 2 DESC
LIMIT 5;

			/*Ques.7 The total number of posts*/
SELECT 
SUM(user_posts.total_posts_per_user) AS 'Total post by Users'
FROM
(SELECT
u.username, COUNT(p.image_url) AS total_posts_per_user
FROM
ig_clone.users u 
JOIN ig_clone.photos p ON u.id = p.user_id
GROUP BY u.id) AS user_posts;

			/*Ques.8 The total number of users with posts*/
SELECT 
    COUNT(DISTINCT u.id) AS total_number_of_users_with_posts
FROM ig_clone.users u
JOIN ig_clone.photos p 
    ON u.id = p.user_id;
			/*Ques.9 The usernames with numbers as ending*/
SELECT 
    id, username
FROM ig_clone.users
WHERE username REGEXP '[0-9]$';

			/*Ques.10 The usernames with character as ending*/
SELECT id, username 
 FROM ig_clone.users
 WHERE username NOT REGEXP '[$0-9]';
 
			/*Ques.11 The number of usernames that start with A*/
SELECT 
COUNT(id)
FROM ig_clone.users 
WHERE username REGEXP '^[A]'; 

			/*Ques.12 The most popular tag names by usage*/
SELECT 
t.tag_name , COUNT(tag_name) AS seen_used
FROM 
ig_clone.tags t
JOIN 
ig_clone.photo_tags pt ON t.id = pt.tag_id
GROUP BY t.id
ORDER BY seen_used DESC
LIMIT 10;

			/*Ques.13 The most popular tag names by likes*/
