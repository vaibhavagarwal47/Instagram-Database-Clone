/* Create the database named Instagram_clone */
CREATE DATABASE Instagram_clone;

USE Instagram_clone;

CREATE TABLE users (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
username VARCHAR(255) UNIQUE NOT NULL,
created_at TIMESTAMP DEFAULT NOW()
);

DESC users;

CREATE TABLE photos (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
image_url VARCHAR(255) NOT NULL,
user_id INTEGER NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id)
);

DESC photos;

CREATE TABLE comments (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
comment_text VARCHAR(255) NOT NULL,
user_id INTEGER NOT NULL,
photo_id INTEGER NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(photo_id) REFERENCES photos(id)
);

DESC comments;

CREATE TABLE likes (
user_id INTEGER NOT NULL,
photo_id INTEGER NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(user_id) REFERENCES users(id),
FOREIGN KEY(photo_id) REFERENCES photos(id),
PRIMARY KEY(user_id,photo_id)
);

DESC likes;

CREATE TABLE follows (
follower_id INTEGER NOT NULL,
followee_id INTEGER NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(follower_id) REFERENCES users(id),
FOREIGN KEY(followee_id) REFERENCES users(id),
PRIMARY KEY(follower_id,followee_id)
);

DESC follows;

CREATE TABLE unfollows (
follower_id INTEGER NOT NULL,
followee_id INTEGER NOT NULL,
created_at TIMESTAMP DEFAULT NOW(),
FOREIGN KEY(follower_id) REFERENCES users(id),
FOREIGN KEY(followee_id) REFERENCES users(id),
PRIMARY KEY(follower_id,followee_id)
);

DESC unfollows;

CREATE TABLE tags (
id INTEGER AUTO_INCREMENT PRIMARY KEY,
tag_name VARCHAR(255) UNIQUE,
created_at TIMESTAMP DEFAULT NOW()
);

DESC tags;

CREATE TABLE photo_tags (
photo_id INTEGER NOT NULL,
tag_id INTEGER NOT NULL,
FOREIGN KEY(photo_id) REFERENCES photos(id),
FOREIGN KEY(tag_id) REFERENCES tags(id),
PRIMARY KEY(photo_id,tag_id)
);

DESC photo_tags;