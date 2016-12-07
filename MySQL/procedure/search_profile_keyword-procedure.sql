delimiter ||
/*drop procedure if exists procedure see_the_profile-procedure*/
create procedure search_profile_keyword ( in keyword varchar(20), in search_username varchar(20), in search_scope tinyint )
begin
        
	set @keyword = CONCAT("%", keyword, "%");
    
    if ( search_scope = 1) then
		select *, 1 as profile_type
		from user_profile
		where (user_name in (select to_user
							 from relation
							 where from_user = search_username
							 union all 
							 select from_user
							 from relation
							 where to_user = search_username))
			   and biography like (@keyword) /* seaching the specific keywords*/
			   and profile_view_priority >= 1 
               /* the view_priority should allow at least their friends to see*/
		order by profile_type asc, user_name asc;
	
    elseif ( search_scope = 2) then
		select *
		from(	
				(select *, 1 as profile_type
				 from user_profile
				 where (user_name in (select to_user
									  from relation
									  where from_user = search_username
									  union all 
									  select from_user
									  from relation
									  where to_user = search_username))
					   and biography like (@keyword) 
                       /* seaching the specific keywords*/
					   and profile_view_priority >= 1 )
        
				union
				
				(select user_profile.*, 2 as profile_type
				from	(  (select to_user as creator_name 
                /* select my friends' friends excluding me*/
							from relation
							where (from_user in (select to_user
												 from relation
												 where from_user = search_username
												 union all 
												 select from_user
												 from relation
												 where to_user = search_username)) 
									/* one person in relationship should be one of my direct friends*/
									and
									(to_user not in (select to_user
													 from relation
													 where from_user = search_username
													 union all 
													 select from_user
													 from relation
													 where to_user = search_username)) 
									/* the other one should be someone who is not a friend of mine*/
							and to_user <> search_username
                            /* discard the query result that returns myself*/
							and from_view_priority >= 1 ) 
                            /* the friendship that your friend would like to show to his friends*/
							union
							(select from_user as creator_name 
                            /* select my friends' friends excluding me*/
							 from relation
							 where (to_user in (select to_user
												from relation
												where from_user = search_username
												union all 
												select from_user
												from relation
												where to_user = search_username)) 
									/* one person in relationship should be one of my direct friends*/
								   and
								   (from_user not in (select to_user
													  from relation
													  where from_user = search_username
													  union all 
													  select from_user
													  from relation
													  where to_user = search_username)) 											
									/* the other one should be someone who is not a friend of mine*/
								   and from_user <> search_username 
                                   /* discard the query result that returns myself*/
								   and to_view_priority >= 1 )  ) as FOF_result, user_profile
				where FOF_result.creator_name = user_profile.user_name and user_profile.profile_view_priority>=2 
					and user_profile.biography like (@keyword) )/* seaching the specific keywords;*/

        )  as all_search_result/* the view_priority should allow at least their friends to see*/
		order by profile_type asc, user_name asc;
        
	else
		select *
		from(	
				(select *, 1 as profile_type
				 from user_profile
				 where (user_name in (select to_user
										 from relation
										 where from_user = search_username
										 union all 
										 select from_user
										 from relation
										 where to_user = search_username))
					   and biography like (@keyword) /* seaching the specific keywords*/
					   and profile_view_priority >= 1 ) 
                       /* the view_priority should allow at least their friends to see*/
				 
				union      

				(select user_profile.*, 2 as profile_type
				from	(  (select to_user as creator_name 
                /* select my friends' friends excluding me*/
							from relation
							where (from_user in (select to_user
												 from relation
												 where from_user = search_username
												 union all 
												 select from_user
												 from relation
												 where to_user = search_username)) 
								/* one person in relationship should be one of my direct friends*/
							and
							(to_user not in (select to_user
											 from relation
											 where from_user = search_username
											 union all 
											 select from_user
											 from relation
											 where to_user = search_username)) 
								/* the other one should be someone who is not a friend of mine*/
							and to_user <> search_username /* discard the query result that returns myself
							and from_view_priority >= 1 ) 
                            /* the friendship that your friend would like to show to his friends*/
						union
						(select from_user as creator_name 
						/* select my friends' friends excluding me*/
						 from relation
						 where (to_user in (select to_user
											from relation
											where from_user = search_username
											union all 
											select from_user
											from relation
											where to_user = search_username)) 
								/* one person in relationship should be one of my direct friends*/
							   and
							   (from_user not in (select to_user
												  from relation
												  where from_user = search_username
												  union all 
												  select from_user
												  from relation
												  where to_user = search_username)) 
								/* the other one should be someone who is not a friend of mine*/
							and from_user <> search_username 
                            /* discard the query result that returns myself*/
							and to_view_priority >= 1 )  ) as FOF_result, user_profile
				where FOF_result.creator_name = user_profile.user_name and profile_view_priority>=2 and biography like (@keyword) )
                /* seaching the specific keywords*/

				union

				(select user_profile.*, 3 as profile_type
				 from user_profile
				 where user_name not in( select *
											from ( 
													select search_username
                                                    from dual
                                                    
                                                    union
                                                    
													(select to_user
													from relation
													where from_user = search_username)
													union
													(select from_user
													from relation
													where to_user = search_username)
                                                    
                                                    union
                                                    
                                                    (select to_user as creator_name 
                                                    /* select my friends' friends excluding me*/
													from relation
													where (from_user in (select to_user
																		 from relation
																		 where from_user = search_username
																		 union all 
																		 select from_user
																		 from relation
																		 where to_user = search_username) ) 
                                                                         /* one person in relationship should be one of my direct friends*/
														   
														   and to_user <> search_username 
                                                           /* discard the query result that returns myself*/
														   and from_view_priority >= 1 ) 
                                                           /* the friendship that your friend would like to show to his friends*/
													union
													(select from_user as creator_name 
                                                    /* select my friends' friends excluding me*/
													 from relation
													 where (to_user in (select to_user
																		from relation
																		where from_user = search_username
																		union all 
																		select from_user
																		from relation
																		where to_user = search_username)) 
                                                                        /* one person in relationship should be one of my direct friends*/
															and from_user <> search_username 
                                                            /* discard the query result that returns myself*/
															and to_view_priority >= 1 )  ) as FOF_result)
					  and profile_view_priority>=3 
                      /* this profile's viewing priority should be anyone*/
					  and biography like (@keyword) )
        ) as all_search_result
		order by profile_type asc, user_name asc;
							
	end if;				
end
delimiter ;

/*
call search_profile_keyword( 'I', 'chelseaisgood', 3 );
/*select * from (select @result in (call DefineTheRelation('chelseaisgood', 'Terminator', @result) ) )
select *
from user_profile;


set @user_name = 'chelseaisgood';
(select to_user
from relation
where from_user = @user_name)
union
(select from_user
from relation
where to_user = @user_name);
*/