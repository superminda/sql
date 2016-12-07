delimiter ||
create procedure get_post_owner ( in post_id varchar ( 20 ) )
begin
	if post_id in ( select P_id from posting ) 
    then select creator_name from posting where P_id = post_id;
    else 
		select "false" as creator_name from dual;
	end if;
end
delimiter ;