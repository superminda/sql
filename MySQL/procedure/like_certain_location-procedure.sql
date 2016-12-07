delimiter ||
create procedure user_like_location ( in liker_name varchar(20), in post_id varchar(20) )
begin
   if liker_name in ( select like_user_name from location_post_like where location_post_like.P_id=post_id ) 
   then 
   		select false as like_location_result from dual;
   else 
		set @location_id = (select L_id from link where link.P_id = post_id);
		insert into location_post_like values ( @location_id, post_id, liker_name, current_timestamp() );
        select true as like_location_result from dual;
   end if;
end
delimiter ;