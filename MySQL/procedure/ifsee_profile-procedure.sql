delimiter ||
/*drop procedure if someone can see the content of certain posting*/
create procedure ifsee_profile ( in see_user varchar(20), in user_id varchar (20) )
begin
	call DefineTheRelation ( see_user, user_id, @define_result);
    if @define_result <= (select profile_view_priority from user_profile where user_name = user_id ) then select true as see_enable from dual;
	else 
		select false as see_enable from dual;
    end if;
end
delimiter ;
