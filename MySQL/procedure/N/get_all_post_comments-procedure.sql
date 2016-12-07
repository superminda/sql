delimiter ||
/*drop procedure if exists get_all_friends_info*/
create procedure get_all_post_comments ( in in_P_id varchar(20) )
begin
	select *
	from post_comments
	where P_id = in_P_id
	order by comment_time desc;
end
delimiter ;

/*
call project.get_all_post_comments('4');
*/