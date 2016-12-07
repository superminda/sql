delimiter ||
create procedure revoke_like_location ( in viewer_name varchar(20), in post_id varchar(20) )
begin
   if viewer_name in ( select like_user_name from location_post_like where location_post_like.P_id=post_id ) 
   then 
        delete from location_post_like where location_post_like.like_user_name = viewer_name and location_post_like.P_id=post_id;
        select true as revoke_like_location_result from dual;
   else 
		select false as revoke_like_location_result from dual;
   end if;
end
delimiter ;