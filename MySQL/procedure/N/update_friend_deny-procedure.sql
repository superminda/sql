delimiter ||
create procedure update_friend_deny ( in deny_from_user varchar(20), in deny_to_user varchar(20) )
begin
	if exists ( select * from relation_history where from_user = deny_from_user and to_user = deny_to_user and friend_status = 0) then
		update relation_history 
        set time_request = current_timestamp(), friend_status = 2
        where from_user = deny_from_user and to_user = deny_to_user and friend_status = 0;
		select true as deny_friend_result from dual;
	else
		select false as deny_friend_result from dual;
	end if;
end
delimiter ;