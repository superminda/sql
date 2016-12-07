delimiter ||
create procedure revoke_like_post ( in viewer_name varchar(20), in post_id varchar(20) )
begin
   if viewer_name in ( select like_user_name from post_like where post_like.P_id=post_id ) 
   then 
        delete from post_like where post_like.like_user_name = viewer_name and post_like.P_id=post_id;
        select true as revoke_like_post_result from dual;
   else 
		select false as revoke_like_post_result from dual;
   end if;
end
delimiter ;