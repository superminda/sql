delimiter ||
create procedure check_user_location_likeness ( in viewer_name varchar(20), in post_id varchar(20) )
begin
   if viewer_name in ( select like_user_name from location_post_like where location_post_like.P_id=post_id ) 
   then select true as location_likeness_result from dual;
   else 
		select false as location_likeness_result from dual;
   end if;
end
delimiter ;