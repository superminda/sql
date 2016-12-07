delimiter ||
create procedure upload_post_comment ( in C_P_id varchar(20), in C_from_user_name varchar(20), in C_to_user_name varchar(20), in C_comment_content text )
begin
	insert into post_comments values (C_P_id, current_timestamp(), C_from_user_name, C_to_user_name, C_comment_content);
	select true as signup_result from dual;
end
delimiter ;

/*
call project.get_all_post_comments('4');
*/