delimiter ||
create procedure signup ( in signup_name varchar(20), in signup_email varchar(40), in signup_pwd varchar(10) )
begin
   if signup_name in ( select user_info.user_name from user_info ) 
   then select false as signup_result from dual;
   else 
		select true as signup_result from dual;
		insert into user_info values (signup_name, signup_email, signup_pwd, current_timestamp() );
end if;
end
delimiter ;