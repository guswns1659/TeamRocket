use angelhack;

insert into project (corporation_id, current_money, dead_line, description, donators, name, target_money)
values (1, 9999, '2020-07-05', 'description', 5, '북극곰 살리기 프로젝트', 10000);

insert into project_account (account_id, project_id) values (1, 1);

insert into project_image (project_id, project_image) values (1, 'www.naver.com');