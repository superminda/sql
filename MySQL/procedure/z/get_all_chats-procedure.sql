delimiter ||
/*drop procedure if two people are friends*/
create procedure get_all_chats ( in user1_name varchar(20), in user2_name varchar(20) )
begin
	select *
    from (
			(select *
			 from bulletin_comments
			 where from_user_name = user1_name and to_user_name = user2_name)
			union
			(select *
			 from bulletin_comments
			 where from_user_name = user2_name and to_user_name = user1_name) ) as chat_return_result
	order by comment_time asc;
end
delimiter ;