use angelhack;
-- drop table if exists account;
-- drop table if exists account_point_history;
-- drop table if exists account_challenge;
-- drop table if exists application_information;
-- drop table if exists project_account;
-- drop table if exists project_image;
-- drop table if exists restaurant_image;
-- drop table if exists application;
-- drop table if exists restaurant;
-- drop table if exists project;
-- drop table if exists corporation;

-- Account
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 1000, 'jack', 2,  20);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 1500, 'cory', 3,  30);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 2000, 'delma', 1, 40);

-- -- PointHistory
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 300, 'SAVE', '북극곰 살리기 프로젝트');
--
-- Challenge
INSERT INTO account_challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (1, CURRENT_TIME , 'description', 1, POINT (126.29216, 33.6632387), '제주식당', CURRENT_TIME , 'www.naver.com');

INSERT INTO account_challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (2, CURRENT_TIME , 'description2', 2, POINT (126.29216, 33.6632387), '전남식당', CURRENT_TIME , 'www.daum.com');

INSERT INTO account_challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (3, CURRENT_TIME , 'description3', 3, POINT (126.29216, 33.6632387), '강남식당', CURRENT_TIME , 'www.daum.com');

INSERT INTO account_challenge (account_id, created_at, description, challenge_like_count, point, challenge_restaurant_name, updated_at, url)
VALUES (1, CURRENT_TIME , 'description4', 4, POINT (126.29216, 33.6632387), '서귀포식당', CURRENT_TIME , 'www.daum.com');


