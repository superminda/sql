delimiter ||
/*drop procedure if two people are friends*/
create procedure if_friend ( in user1_name varchar(20), in user2_name varchar(20) )
begin
	if user2_name in ( select * 
                      from ((select to_user
						     from relation
							 where from_user = user1_name)
							union all
			                (select from_user
			                 from relation
			                 where to_user = user1_name)) as friends_output ) then select "true" as define_result from dual;
	else 
		select "false" as define_result from dual;
    end if;
end
delimiter ;

/*
set @user1_name = "chelseaisgood";
#set @user2_name = "Juan Mata";
#set @user2_name = "Terminator";
set @user2_name = "Titanic";
#DECLARE @friends_list varchar(20);
call DefineTheRelation(@user1_name, @user2_name, @result);
*/