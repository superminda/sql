
/* 
function:
1. updating the post like number after people like or revoke like on it
*/


delimiter ||
create trigger recount_post_likeness1 after insert on post_like
for each row
begin
	update posting set like_num = (select count(*) from post_like where post_like.P_id = new.P_id  group by P_id) where posting.P_id = new.P_id;
end||
delimiter ;


/*
set SQL_SAFE_UPDATES = 0; 
INSERT INTO post_like VALUES ( 1, 'Juan Mata', '2016-04-01 11:28:00');  
set SQL_SAFE_UPDATES = 1; 
*/

delimiter ||
create trigger recount_post_likeness2 after delete on post_like
for each row
begin
	update posting set like_num = (select count(*) from post_like where post_like.P_id = old.P_id  group by P_id) where posting.P_id = old.P_id;
end||
delimiter ;

#DELETE FROM post_like where P_id= 1 and like_user_name ='Juan Mata' ;  