delimiter ||
create procedure check_post_location_likeness ( in location_id varchar(20), in post_id varchar(20) )
begin
	if exists ( select * from location_post_like where location_post_like.P_id=post_id and location_post_like.L_id=location_id ) then
		select count(like_user_name) as loc_like_num
		from location_post_like
		where location_post_like.P_id=post_id and location_post_like.L_id=location_id
		group by P_id, L_id;
	else
		select 0 as loc_like_num
        from dual;
	end if;
end
delimiter ;