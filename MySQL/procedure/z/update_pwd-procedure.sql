delimiter ||
CREATE PROCEDURE update_pwd( in new_pwd varchar(20), in old_pwd varchar(20), in edit_pwd_user varchar(20))
begin
	if(old_pwd <> (select pwd from user_info where user_name = edit_pwd_user)) then
		select false as change_pwd_result from dual;
	else 
		update user_info set user_info.pwd = new_pwd where user_info.user_name = edit_pwd_user;
        select true as change_pwd_result from dual;
	end if;
end
delimiter;


