delimiter ||
create procedure check_post_likeness ( in post_liker_name varchar(20), in post_id varchar(20) )
begin
	if post_liker_name in ( select like_user_name from post_like where post_like.P_id=post_id ) then
		select true as post_likeness_result from dual;
	else
		select false as post_likeness_result from dual;
	end if;
end
delimiter ;