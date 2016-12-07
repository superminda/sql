delimiter ||
#drop procedure if exists find_all_friends
create procedure DefineTheRelation2 ( in user1_name varchar(20), in user2_name varchar(20) )
begin
	set @isfriend = 1;
    set @isFOF = 2;
    set @isanyone = 3;
	if user2_name in ( select * 
                      from ((select to_user
						     from relation
							 where from_user = user1_name)
							union all
			                (select from_user
			                 from relation
			                 where to_user = user1_name)) as friends_output ) then select @isfriend from dual;
	elseif user2_name in ( select *
						   from (	(select to_user as FOF# select my friends' friends excluding me
									 from relation
									 where (from_user in (select to_user
														  from relation
														  where from_user = user1_name
														  union all 
														  select from_user
														  from relation
														  where to_user = user1_name)) # one person in relationship should be one of my direct friends
											and
											(to_user not in (select to_user
															 from relation
															 where from_user = user1_name
															 union all 
															 select from_user
															 from relation
															 where to_user = user1_name)) # the other one should be someone who is not a friend of mine
											and to_user <> user1_name # discard the query result that returns myself
											and from_view_priority >= 1) # the friendship that your friend would like to show to his friends
									union
									(select from_user as FOF # select my friends' friends excluding me
									 from relation
									 where (to_user in (select to_user
														from relation
														where from_user = user1_name
														union all 
														select from_user
														from relation
														where to_user = user1_name)) # one person in relationship should be one of my direct friends
											and
											(from_user not in (select to_user
															   from relation
															   where from_user = user1_name
															   union all 
															   select from_user
															   from relation
															   where to_user = user1_name)) # the other one should be someone who is not a friend of mine
											and from_user <> user1_name # discard the query result that returns myself
											and to_view_priority >= 1) ) as FOF_output # the friendship that your friend would like to show to his friends
						) then select @isFOF from dual;
	else select @isanyone from dual;
    end if;
end
delimiter ;