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
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 500, 'delma', 1, 10);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 1000, 'jack', 2,  20);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 1500, 'cory', 3,  30);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 2000, 'poogle', 3,  40);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 2500, 'solar', 3,  50);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 3000, 'ever', 3,  60);
INSERT INTO account (eco_point, name, today_plate, total_plate) VALUES ( 3500, 'david', 3,  70);

-- -- PointHistory
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 300, 'SAVE', '북극곰 살리기 프로젝트');
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 400, 'SAVE', '북극곰 살리기 프로젝트');
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 500, 'SAVE', '북극곰 살리기 프로젝트');
INSERT INTO account_point_history (account_id, created_at, eco_point, point_option, project_name)
VALUES (1, CURRENT_TIME , 600, 'SAVE', '북극곰 살리기 프로젝트');



