delimiter ||
/*drop procedure if someone can see the content of certain posting*/
create procedure ifsee_post ( in see_user varchar(20), in post_id varchar ( 20 ) )
begin
	set @owner_name = ( select creator_name from posting where P_id = post_id );
    call DefineTheRelation ( see_user, @owner_name, @define_result);
    if @define_result <= (select post_view_priority from posting where P_id = post_id ) then select "true" as see_enable from dual;
	else 
		select "false" as see_enable from dual;
    end if;
end
delimiter ;
