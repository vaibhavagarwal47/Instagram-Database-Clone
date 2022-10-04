-- Some basic queries regarding the database

-- 1) Query to find the first 5 users
SELECT * FROM users
ORDER BY created_at LIMIT 5;

-- 2) What day of a week do most users register on?
SELECT DAYNAME(created_at), COUNT(*)
FROM users
GROUP BY DAYNAME(created_at)
ORDER BY COUNT(*) DESC;

-- 3) Users who never posted Photos
SELECT username
FROM users
LEFT JOIN photos p on users.id = p.user_id
WHERE p.id IS NULL;

-- 4) Most likes on a photo and it's user
-- METHOD 1)
SELECT COUNT(user_id), photo_id
FROM likes
GROUP BY photo_id
ORDER BY COUNT(user_id) DESC
LIMIT 1;
-- METHOD 2)
SELECT p.id AS ID,
       p.image_url AS IMG_URL,
       l.user_id AS USER_ID,
       COUNT(*) AS TOTAL_LIKES
FROM photos p
         INNER JOIN likes l ON l.photo_id = p.id
GROUP BY p.id
ORDER BY COUNT(*) DESC LIMIT 1;

-- 5) How many times does an average user posts
SELECT (SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users)
AS AVERAGE_POSTS;

-- 6) Top 5 Common Hashtags
SELECT t.tag_name AS TAG,
       COUNT(*) AS TOTAL_MENTIONS
FROM tags t
         JOIN photo_tags pt ON t.id = pt.tag_id
GROUP BY t.id
ORDER BY TOTAL_MENTIONS DESC
LIMIT 5;

-- 7) Username who has liked every photo
SELECT username,
       COUNT(*) AS LIKES
FROM users
INNER JOIN likes l on users.id = l.user_id
GROUP BY l.user_id
HAVING LIKES=(SELECT COUNT(*) FROM photos);
