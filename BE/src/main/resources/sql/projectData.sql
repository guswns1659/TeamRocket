use anglehack;

insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (1, '2020-05-11' , 2721800, '2020-09-30', 'description', 523, '해양 포유류 보호법 후원 프로젝트', 9900000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (2, '2020-06-12' , 1956000, '2020-07-30', 'description', 173, '해양 쓰레기 줍기 프로젝트', 4300000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (3, '2020-05-13' , 1382300, '2020-08-30', 'description', 51, '순천만 습지에 맹꽁이 살리기 프로젝트', 1864000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (4, '2020-05-14' , 6198200, '2020-10-30', 'description', 231, '북극곰 살리기 프로젝트', 9900000);
insert into project (corporation_id, created_at, current_money, dead_line, description, donators, name, target_money)
values (5, '2020-07-15' , 3788000, '2020-09-27', 'description', 98, '개마고원에 나무 심기 프로젝트', 5000000);

insert into project_account (account_id, project_id) values (1, 1);
insert into project_account (account_id, project_id) values (1, 2);
insert into project_account (account_id, project_id) values (1, 3);
insert into project_account (account_id, project_id) values (2, 4);
insert into project_account (account_id, project_id) values (2, 5);


insert into project_image (project_id, project_image) values (1, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%8F%AC%EC%9C%A0%EB%A5%981.jpeg');
insert into project_image (project_id, project_image) values (2, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/download%20new1');
insert into project_image (project_id, project_image) values (3, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/download%20%282%29%20new5');
insert into project_image (project_id, project_image) values (4, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%EB%B6%81%EA%B7%B9%EA%B3%B0%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');
insert into project_image (project_id, project_image) values (5, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/%EB%82%98%EB%AC%B4%EC%8B%AC%EA%B8%B0%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8.jpeg%20new');

insert into project_image (project_id, project_image) values (1, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%8F%AC%EC%9C%A0%EB%A5%982.jpg');
insert into project_image (project_id, project_image) values (2, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%95%B4%EC%96%911.jpg');
insert into project_image (project_id, project_image) values (3, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%A7%B9%EA%BD%81%EC%9D%B42.jpeg');
insert into project_image (project_id, project_image) values (4, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%B6%81%EA%B7%B9%EA%B3%B02.jpg');
insert into project_image (project_id, project_image) values (5, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%82%98%EB%AC%B42.jpeg');

insert into project_image (project_id, project_image) values (1, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%8F%AC%EC%9C%A0%EB%A5%983.jpg');
insert into project_image (project_id, project_image) values (2, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%95%B4%EC%96%913.jpg');
insert into project_image (project_id, project_image) values (3, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%A7%B9%EA%BD%81%EC%9D%B43.jpeg');
insert into project_image (project_id, project_image) values (4, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%B6%81%EA%B7%B9%EA%B3%B03.jpg');
insert into project_image (project_id, project_image) values (5, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%82%98%EB%AC%B43.jpeg');

insert into project_image (project_id, project_image) values (1, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%8F%AC%EC%9C%A0%EB%A5%984.jpg');
insert into project_image (project_id, project_image) values (2, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%ED%95%B4%EC%96%914.jpg');
insert into project_image (project_id, project_image) values (3, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%A7%B9%EA%BD%81%EC%9D%B44.jpeg');
insert into project_image (project_id, project_image) values (4, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%B6%81%EA%B7%B9%EA%B3%B04.jpg');
insert into project_image (project_id, project_image) values (5, 'https://s3-angelhack.s3.ap-northeast-2.amazonaws.com/static/projectImage/%EB%82%98%EB%AC%B44.jpg');

