delimiter ||
create procedure update_friend_accept ( in accept_from_user varchar(20), in accept_to_user varchar(20) )
begin
	if exists ( select * from relation_history where from_user = accept_from_user and to_user = accept_to_user and friend_status = 0) then
		update relation_history 
        set time_request = current_timestamp(), friend_status = 1
        where from_user = accept_from_user and to_user = accept_to_user and friend_status = 0;
		select true as accept_friend_result from dual;
	else
		select false as accept_friend_result from dual;
	end if;
end
delimiter ;