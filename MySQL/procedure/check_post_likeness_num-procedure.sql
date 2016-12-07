delimiter ||
create procedure check_post_likeness_num ( in post_id varchar(20) )
begin
	if exists ( select * from post_like where post_like.P_id=post_id and post_like.P_id=post_id ) then
		select count(like_user_name) as post_like_num
		from post_like
		where post_like.P_id=post_id
		group by P_id;
	else
		select 0 as post_like_num
        from dual;
	end if;
end
delimiter ;