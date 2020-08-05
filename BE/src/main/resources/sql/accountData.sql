use anglehack;
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
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 500, 'delma', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 0, 10);
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 1000, 'jack', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 0, 20);
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 1500, 'cory', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 0, 30);
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 2000, 'poogle', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 0, 40);
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 2500, 'solar', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 0, 50);
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 3000, 'ever', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 0, 60);
INSERT INTO account (eco_point, name, profile_url, today_plate, total_plate)
VALUES ( 3500, 'david', 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/delma.png', 3, 70);

-- -- PointHistory
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 300, 'DONATE', '북극곰 살리기 프로젝트');
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 400, 'DONATE', '북극곰 살리기 프로젝트');
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 500, 'DONATE', '북극곰 살리기 프로젝트');
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 600, 'DONATE', '북극곰 살리기 프로젝트');



