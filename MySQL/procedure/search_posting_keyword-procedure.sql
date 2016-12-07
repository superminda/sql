delimiter ||
/*drop procedure if exists procedure search_posting_keyword*/
create procedure search_posting_keyword ( in keyword varchar(20), in search_username varchar(20), in search_scope tinyint, in search_starttime_type varchar(20) )
begin
	/* set the search_starttime according to the type*/
	if search_starttime_type = 'Today' then
		set @starttime_date = current_date();
	elseif search_starttime_type = 'Last three days' then 
		set @starttime_date = (SELECT DATE_SUB(current_date(), INTERVAL 3 DAY)); 
    elseif search_starttime_type = 'Last seven days' then 
		set @starttime_date = (SELECT DATE_SUB(current_date(), INTERVAL 7 DAY));     
	elseif search_starttime_type = 'Last month' then 
		set @starttime_date = (SELECT DATE_SUB(current_date(), INTERVAL 1 MONTH));   
	elseif search_starttime_type = 'Last year' then 
		set @starttime_date = (SELECT DATE_SUB(current_date(), INTERVAL 1 YEAR));  
	else
		set @starttime_date = "2000-01-01";
	end if;
        
	set @starttime_timestamp = CONCAT(@starttime_date, " 00:00:00"); /*convert date into timestamp type*/
        
	set @keyword = CONCAT("%", keyword, "%");
    
    if ( search_scope = 1) then
		select *
		from posting natural left join link natural left join location
		where (creator_name in (select to_user
								from relation
								where from_user = search_username
								union all 
								select from_user
								from relation
								where to_user = search_username))
			   and textfile like (@keyword) /* seaching the specific keywords*/
			   and P_time >= @starttime_timestamp
			   and post_view_priority >= 1 
               /* the view_priority should allow at least their friends to see */ 
		order by P_time desc;
	
    elseif ( search_scope = 2) then
		select *
		from(	(select posting.*
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
									   and to_view_priority >= 1 )  ) as FOF_result, posting
						where FOF_result.creator_name = posting.creator_name 
							  and P_time >= @starttime_timestamp
							  and post_view_priority>=2 and textfile like (@keyword) )
                              /* seaching the specific keywords*/

						union

						(select *
						 from posting
						 where (creator_name in (select to_user
												 from relation
												 where from_user = search_username
												 union all 
												 select from_user
												 from relation
												 where to_user = search_username))
							   and textfile like (@keyword) 
                               /* seaching the specific keywords*/
							   and P_time >= @starttime_timestamp
							   and post_view_priority >= 1 )	)  as all_search_result natural left join link natural left join location
                               /* the view_priority should allow at least their friends to see*/
		order by P_time desc;
        
	else
		select *
		from(	(select *
				 from posting
				 where (creator_name in (select to_user
										 from relation
										 where from_user = search_username
										 union all 
										 select from_user
										 from relation
										 where to_user = search_username))
					   and textfile like (@keyword) 
                       /* seaching the specific keywords*/
					   and P_time >= @starttime_timestamp
					   and post_view_priority >= 1 ) 
                       /* the view_priority should allow at least their friends to see*/
				 
				union      

				(select posting.*
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
						(select from_user as creator_name /* select my friends' friends excluding me*/
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
							   and to_view_priority >= 1 )  ) as FOF_result, posting
				where FOF_result.creator_name = posting.creator_name 
					  and P_time >= @starttime_timestamp
					  and post_view_priority>=2 and textfile like (@keyword) )
                      /* seaching the specific keywords;*/

				union

				(select posting.*
				 from posting
				 where creator_name not in( select *
											from ( (select to_user as creator_name 
                                            /* select my friends' friends and me*/
													from relation
													where (from_user in (select to_user
																		 from relation
																		 where from_user = search_username
																		 union all 
																		 select from_user
																		 from relation
																		 where to_user = search_username) ) 
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
														   /*and to_user <> search_username */
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
															/*and from_user <> search_username /* discard the query result that returns myself*/
															and to_view_priority >= 1 )  ) as FOF_result)
					  and post_view_priority>=3 /* this posting's viewing priority should be anyone*/
					  and P_time >= @starttime_timestamp
					  and textfile like (@keyword) )	) as all_search_result natural left join link natural left join location
	order by P_time desc;
							
	end if;				
end
delimiter ;

/*
select *
from posting
where textfile like (@keyword) and (P_time between @starttime_timestamp and current_timestamp()) 
	and post_view_prioirty >= (select * from (call DefineTheRelation(search_username, creator_name, @result)))
order by P_time desc;
*/

/*
call search_posting_keyword( 'began', 'Yujia Zhai', 3, 'Last year' );
call search_posting_keyword( 'I', 'chelseaisgood', 3, 'Last seven days' );
call search_posting_keyword( 'I', 'chelseaisgood', 3, 'Last month' );
call search_posting_keyword( 'I', 'chelseaisgood', 3, 'Last year' );
select *
from posting;
*/