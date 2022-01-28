-- CHALLENGE 1

-- We want to reward our users who have been around the longest.  
-- Find the 5 oldest users.

SELECT * 
FROM users
ORDER BY created_at
LIMIT 5;

-- CHALLENGE 2

-- What day of the week do most users register on?
-- We need to figure out when to schedule an ad campgain

SELECT 
username,
DAYNAME(created_at) AS day_name,
COUNT(DAYNAME(created_at)) AS COUNT
FROM users
-- WHERE COUNT = MAX(COUNT(DAYNAME(created_at)))
GROUP BY day_name
ORDER BY COUNT DESC LIMIT 2;

-- CHALLENGE 3

-- We want to target our inactive users with an email campaign.
-- Find the users who have never posted a photo

SELECT username,
image_url
FROM users 
LEFT JOIN photos
ON users.id = photos.user_id
WHERE image_url IS NULL;

 -- it is used to find the oldest active user and latest active user
 
 SELECT username,
image_url,
photos.created_at
FROM users 
LEFT JOIN photos
ON users.id = photos.user_id
ORDER BY photos.created_at;
-- ORDER BY photos.created_at DESC;

-- CHALLENGES 4

-- We're running a new contest to see who can get the most likes on a single photo.
-- WHO WON??!!

SELECT photos.id,
photos.image_url,
likes.photo_id,
likes.user_id,
COUNT(likes.photo_id) AS count,
users.username
FROM photos
JOIN likes
ON photos.id = likes.photo_id
JOIN users
ON photos.user_id = users.id
GROUP BY likes.photo_id
ORDER BY count DESC 
LIMIT 1;

-- CHALLANGE 5

-- Our Investors want to know...
-- How many times does the average user post?

-- SELECT users.username,
-- photos.image_url,
-- photos.user_id,
-- COUNT(photos.user_id) AS count
-- FROM users
-- JOIN photos
-- ON users.id = photos.user_id
-- GROUP BY photos.user_id
-- ORDER BY count DESC;

 SELECT 
	(SELECT COUNT(*) FROM photos) / (SELECT COUNT(*) FROM users);

-- CHALLANGE 6

-- A brand wants to know which hashtags to use in a post
-- What are the top 5 most commonly used hashtags?

SELECT tags.tag_name, 
       Count(*) AS total 
FROM   photo_tags 
       JOIN tags 
         ON photo_tags.tag_id = tags.id 
GROUP  BY tags.id 
ORDER  BY total DESC 
LIMIT  5; 

-- CHALLANGES 7

-- We have a small problem with bots on our site...
-- Find users who have liked every single photo on the site

SELECT username, 
       Count(*) AS num_likes 
FROM   users 
       INNER JOIN likes 
               ON users.id = likes.user_id 
GROUP  BY likes.user_id 
HAVING num_likes = (SELECT Count(*) 
                    FROM   photos);
