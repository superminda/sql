/*===========find all people's posting which containing keyword "healthy" ===========*/
set @user_name = 'Terminator';
set @keyword = '%healthy%';
select *
from (
		(select *
		 from posting
		 where (creator_name in (select to_user
								 from relation
								 where from_user = @user_name
								 union all 
								 select from_user
								 from relation
								 where to_user = @user_name))
			   and textfile like (@keyword) 
               /* seaching the specific keywords*/
			   and post_view_priority >= 1 ) 
               /* the view_priority should allow at least their friends to see*/
		 
		union      

		(select posting.*
		from	(  (select to_user as creator_name 
					/* select my friends' friends excluding me*/
					from relation
					where (from_user in (select to_user
										 from relation
										 where from_user = @user_name
										 union all 
										 select from_user
										 from relation
										 where to_user = @user_name)) 
                                         /* one person in relationship should be one of my direct friends*/
					and
					(to_user not in (select to_user
									 from relation
									 where from_user = @user_name
									 union all 
									 select from_user
									 from relation
									 where to_user = @user_name)) 
                                     /* the other one should be someone who is not a friend of mine*/
					and to_user <> @user_name 
                    /* discard the query result that returns myself*/
					and from_view_priority >= 1 ) 
                    /* the friendship that your friend would like to show to his friends*/
				union
				(select from_user as creator_name 
                /* select my friends' friends excluding me*/
				 from relation
				 where (to_user in (select to_user
									from relation
									where from_user = @user_name
									union all 
									select from_user
									from relation
									where to_user = @user_name)) 
                                    /* one person in relationship should be one of my direct friends*/
					   and
					   (from_user not in (select to_user
										  from relation
										  where from_user = @user_name
										  union all 
										  select from_user
										  from relation
										  where to_user = @user_name)) 
                                          /* the other one should be someone who is not a friend of mine*/
					   and from_user <> @user_name 
                       /* discard the query result that returns myself*/
					   and to_view_priority >= 1 )  ) as FOF_result, posting
		where FOF_result.creator_name = posting.creator_name and post_view_priority>=2 and textfile like (@keyword) )
        /* seaching the specific keywords*/

		union

		(select posting.*
		 from posting
		 where creator_name not in( select *
									from ( (select to_user as creator_name 
                                    /* select my friends' friends excluding me*/
											from relation
											where (from_user in (select to_user
																 from relation
																 where from_user = @user_name
																 union all 
																 select from_user
																 from relation
																 where to_user = @user_name) ) 
                                                                 /* one person in relationship should be one of my direct friends*/
												   and
												  (to_user not in (select to_user
																   from relation
																   where from_user = @user_name
																   union all 
																   select from_user
																   from relation
																   where to_user = @user_name)) 
                                                                   /* the other one should be someone who is not a friend of mine*/
												   and to_user <> @user_name 
                                                   /* discard the query result that returns myself*/
												   and from_view_priority >= 1 ) 
                                                   /* the friendship that your friend would like to show to his friends*/
											union
											(select from_user as creator_name 
                                            /* select my friends' friends excluding me*/
											 from relation
											 where (to_user in (select to_user
																from relation
																where from_user = @user_name
																union all 
																select from_user
																from relation
																where to_user = @user_name)) 
                                                                /* one person in relationship should be one of my direct friends*/
													and
													(from_user not in (select to_user
																	   from relation
																	   where from_user = @user_name
																	   union all 
																	   select from_user
																	   from relation
																	   where to_user = @user_name)) 
                                                                       /* the other one should be someone who is not a friend of mine*/
													and from_user <> @user_name 
                                                    /* discard the query result that returns myself*/
													and to_view_priority >= 1 )  ) as FOF_result)
			  and post_view_priority>=3 
              /* this posting's viewing priority should be anyone*/
			  and textfile like (@keyword) ) ) as final_result
order by P_time desc;
 