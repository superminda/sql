delimiter ||
create procedure user_like_post ( in liker_name varchar(20), in post_id varchar(20) )
begin
   if liker_name in ( select like_user_name from post_like where post_like.P_id=post_id ) 
   then 
   		select false as like_post_result from dual;
   else 
		insert into post_like values ( post_id, liker_name, current_timestamp() );
        select true as like_post_result from dual;
   end if;
end
delimiter ;