delimiter ||
/* status = 0, update time_request, else insert new turple to relation_history*/
create procedure ifexists_friend_history ( in addfriend_from_user varchar(20),in addfriend_to_user varchar(20))
begin

	if exists ( select * 
				from relation_history 
				where friend_status = 0 and from_user=addfriend_from_user and to_user=addfriend_to_user) then 
		update relation_history set relation_history.time_request = current_timestamp() 
		where relation_history.from_user = addfriend_from_user and relation_history.to_user = addfriend_to_user;
		select true as exist_result from dual;
	else 
		insert into relation_history(from_user,to_user,time_request,friend_status)
		values (addfriend_from_user,addfriend_to_user,current_timestamp(),0);
		select false as exist_result from dual;
    end if;
end
delimiter ;