delimiter ||
/*drop procedure if exists find_all_friends*/
create procedure ifexists_user ( in user_name varchar(20) )
begin
	set @exist = true;
    set @notexist = false;
    
	if user_name in ( select user_info.user_name 
                      from user_info ) then select true as define from dual;
	else select false as define from dual;
    end if;
end
delimiter ;
/*
create procedure ifexists_user ( in user_name varchar(20),  out define_result tinyint )
begin
	set @exist = true;
    set @notexist = false;
    
	if user_name in ( select user_info.user_name 
                      from user_info ) then set define_result = @exist;
	else set define_result = @notexist;
    end if;
end
*/

/*
set @user1_name = "chelseaisgood";
#set @user2_name = "Juan Mata";
#set @user2_name = "Terminator";
set @user2_name = "Titanic";
#DECLARE @friends_list varchar(20);
call DefineTheRelation(@user1_name, @user2_name, @result);
*/