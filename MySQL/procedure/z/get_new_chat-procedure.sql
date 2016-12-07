delimiter ||
create procedure get_new_chat( in user1_name varchar(20), in user2_name varchar(20), in lasttime timestamp)
begin
	select * from bulletin_comments
			 where from_user_name = user2_name 
             and to_user_name = user1_name
             and lasttime < comment_time
	order by comment_time asc;
end
delimiter；