delimiter ||
/*drop procedure if login*/
create procedure login ( in login_name varchar(20), in login_pwd varchar(10) )
begin
	if login_pwd = ( select user_info.pwd from user_info where user_name = login_name  ) then select true as login_result from dual;
	else select false as login_result from dual;
    end if;
end
delimiter ;