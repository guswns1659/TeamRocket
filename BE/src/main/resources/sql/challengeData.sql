-- Challenge
INSERT INTO challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (1, CURRENT_TIME , 'description', 1, POINT (126.29216, 33.6632387), '제주식당', CURRENT_TIME , 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/empty_image1.jpeg%20new');

INSERT INTO challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (2, CURRENT_TIME , 'description2', 2, POINT (126.29216, 33.6632387), '전남식당', CURRENT_TIME , 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/empty_image2.jpeg%20new');

INSERT INTO challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (3, CURRENT_TIME , 'description3', 3, POINT (126.29216, 33.6632387), '강남식당', CURRENT_TIME , 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/empty_image3.jpeg%20new');

INSERT INTO challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (1, CURRENT_TIME , 'description4', 4, POINT (126.29216, 33.6632387), '서귀포식당', CURRENT_TIME , 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/empty_image4.jpg%20new');

insert into challenge_like (challenge_id, account_name) values (1, 'delma');
insert into challenge_like (challenge_id, account_name) values (1, 'jack');
