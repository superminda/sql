delimiter ||
/*drop procedure if exists find_all_friends*/
create procedure DefineTheRelation ( in user1_name varchar(20), in user2_name varchar(20), out define_result tinyint )
begin
	set @isMe = 0;
	set @isfriend = 1;
    set @isFOF = 2;
    set @isanyone = 3;
	if (user1_name = user2_name) then set define_result = @isMe;
	elseif user2_name in ( select * 
                      from ((select to_user
						     from relation
							 where from_user = user1_name)
							union all
			                (select from_user
			                 from relation
			                 where to_user = user1_name)) as friends_output ) then set define_result = @isfriend;
	elseif user2_name in ( select *
						   from (	(select to_user as FOF
									/* select my friends' friends excluding me*/
									 from relation
									 where (from_user in (select to_user
														  from relation
														  where from_user = user1_name
														  union all 
														  select from_user
														  from relation
														  where to_user = user1_name)) 
											/* one person in relationship should be one of my direct friends*/
											and
											(to_user not in (select to_user
															 from relation
															 where from_user = user1_name
															 union all 
															 select from_user
															 from relation
															 where to_user = user1_name)) 
											/* the other one should be someone who is not a friend of mine*/
											and to_user <> user1_name 
                                            /* discard the query result that returns myself*/
											and from_view_priority >= 1) 
                                            /* the friendship that your friend would like to show to his friends*/
									union
									(select from_user as FOF 
                                    /* select my friends' friends excluding me*/
									 from relation
									 where (to_user in (select to_user
														from relation
														where from_user = user1_name
														union all 
														select from_user
														from relation
														where to_user = user1_name)) 
											/* one person in relationship should be one of my direct friends*/
											and
											(from_user not in (select to_user
															   from relation
															   where from_user = user1_name
															   union all 
															   select from_user
															   from relation
															   where to_user = user1_name)) 
											/* the other one should be someone who is not a friend of mine*/
											and from_user <> user1_name 
                                            /* discard the query result that returns myself*/
											and to_view_priority >= 1) ) as FOF_output 
                                            /* the friendship that your friend would like to show to his friends*/
						) then set define_result = @isFOF;
	else set define_result = @isanyone;
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