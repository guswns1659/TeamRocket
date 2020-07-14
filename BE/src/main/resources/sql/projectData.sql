use angelhack;

insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (1, '2020-07-11' , 9000, '2020-07-21', 'description', 5, '해양 포유류 보호법 후원 프로젝트', 10000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (2, '2020-07-12' , 9000, '2020-07-22', 'description', 5, '해양 쓰레기 줍기 프로젝트', 10000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (3, '2020-07-13' , 9000, '2020-07-23', 'description', 5, '순천만 습지에 맹꽁이 살리기 프로젝트', 10000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (4, '2020-07-14' , 9000, '2020-07-24', 'description', 5, '북극곰 살리기 프로젝트', 10000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (5, '2020-07-15' , 9000, '2020-07-25', 'description', 5, '개마고원에 나무 심기 프로젝트', 10000);

insert into project_account (account_id, project_id) values (1, 1);
insert into project_account (account_id, project_id) values (1, 2);
insert into project_account (account_id, project_id) values (1, 3);
insert into project_account (account_id, project_id) values (1, 4);
insert into project_account (account_id, project_id) values (1, 5);

insert into project_image (project_id, project_image) values (1, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%ED%95%B4%EC%96%91%ED%8F%AC%EC%9C%A0%EB%A5%98%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');
insert into project_image (project_id, project_image) values (2, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%ED%95%B4%EC%96%91%EC%93%B0%EB%A0%88%EA%B8%B0%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');
insert into project_image (project_id, project_image) values (3, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%EC%88%9C%EC%B2%9C%EB%A7%8C%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');
insert into project_image (project_id, project_image) values (4, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%EB%B6%81%EA%B7%B9%EA%B3%B0%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');
insert into project_image (project_id, project_image) values (5, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%EB%82%98%EB%AC%B4%EC%8B%AC%EA%B8%B0%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');
