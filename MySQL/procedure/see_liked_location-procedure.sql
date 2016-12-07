delimiter ||
/*drop procedure if exists see_the_profile*/
create procedure see_friendliked_location ( in client_name varchar(20) )
begin
	/*alert locations liked by friends*/
     (
		select *
		from(	
				(select location_post_like.like_user_name as people, 
						'like_loca' as new_item_type, location_post_like.like_time as new_item_time, 
							location.L_id as new_item_content, 
								posting.P_id as link_addr, 
									posting.creator_name as carrier_name
				 from posting natural join location_post_like natural join location
				 where posting.creator_name =client_name
					   and location_post_like.like_user_name in (select to_user
															     from relation
												                 where from_user = client_name
												                 union all 
												                 select from_user
												                 from relation
																 where to_user = client_name)
					   and location_post_like.like_time >= ( select lasttime_access from user_info where user_name = client_name )
				 order by like_time desc, like_user_name asc 
                 )
				 
				union  
                
                
				(select location_post_like.like_user_name as people, 
						'like_loca' as new_item_type, 
							location_post_like.like_time as new_item_time, 
								location.L_id as new_item_content, 
									posting.P_id as link_addr, 
										posting.creator_name as carrier_name
				 from posting natural join location_post_like natural join location
				 where (posting.creator_name in (select to_user
												 from relation
												 where from_user = client_name
												 union all 
												 select from_user
												 from relation
												 where to_user = client_name))
					   and location_post_like.like_user_name in (select to_user
															     from relation
												                 where from_user = client_name
												                 union all 
												                 select from_user
												                 from relation
																 where to_user = client_name)
					   and location_post_like.like_time >= ( select lasttime_access from user_info where user_name = client_name )
					   and posting.post_view_priority >= 1  
                       /* the view_priority should allow at least their friends to see*/
				 order by like_time desc, like_user_name asc 
                 )
				 
				union      

				(select location_post_like.like_user_name as people, 
							'like_loca' as new_item_type, 
									location_post_like.like_time as new_item_time, 
										location.L_id as new_item_content, 
											posting.P_id as link_addr, 
												posting.creator_name as carrier_name
				from	(  (select to_user as creator_name 
                /* select my friends' friends excluding me*/
							from relation
							where (from_user in (select to_user
												 from relation
												 where from_user = client_name
												 union all 
												 select from_user
												 from relation
												 where to_user = client_name)) 
									/* one person in relationship should be one of my direct friends*/
									and
									(to_user not in (select to_user
													 from relation
													 where from_user = client_name
													 union all 
													 select from_user
													 from relation
													 where to_user = client_name)) 
									/* the other one should be someone who is not a friend of mine*/
									and to_user <> client_name 
                                    /* discard the query result that returns myself*/
									and from_view_priority >= 1 ) 
                                    /* the friendship that your friend would like to show to his friends*/
						union
                        
						(select from_user as creator_name 
                        /* select my friends' friends excluding me*/
						 from relation
						 where (to_user in (select to_user
											from relation
											where from_user = client_name
											union all 
											select from_user
											from relation
											where to_user = client_name)) 
								/* one person in relationship should be one of my direct friends*/
							   and
							   (from_user not in (select to_user
												  from relation
												  where from_user = client_name
												  union all 
												  select from_user
												  from relation
												  where to_user = client_name)) 
										/* the other one should be someone who is not a friend of mine*/
								and from_user <> client_name 
                                /* discard the query result that returns myself*/
								and to_view_priority >= 1 )  ) as FOF_result natural join posting natural join location_post_like natural join location
				where posting.post_view_priority>=2 
                      and location_post_like.like_user_name in (select to_user
																from relation
																where from_user = client_name
																union all 
																select from_user
																from relation
																where to_user = client_name)
					  and location_post_like.like_time >= ( select lasttime_access from user_info where user_name = client_name )		
				order by like_time desc, like_user_name asc 
                )
                    
				union

				(select location_post_like.like_user_name as people, 'like_loca' as new_item_type, location_post_like.like_time as new_item_time, 
					location.L_id as new_item_content, posting.P_id as link_addr, posting.creator_name as carrier_name
				 from posting natural join location_post_like natural join location
				 where posting.creator_name not in( select *
													from ( 
															select client_name
															from dual
															
															union
															
															(select to_user
															from relation
															where from_user = client_name)
															union
															(select from_user
															from relation
															where to_user = client_name)
															
															union
															
															(select to_user as creator_name 
                                                            /* select my friends' friends excluding me*/
															from relation
															where (from_user in (select to_user
																				 from relation
																				 where from_user = client_name
																				 union all 
																				 select from_user
																				 from relation
																				 where to_user = client_name) ) 
															/* one person in relationship should be one of my direct friends*/
																   
																   and to_user <> client_name 
															/* discard the query result that returns myself*/
																   and from_view_priority >= 1 ) 
															/* the friendship that your friend would like to show to his friends*/
															union
															(select from_user as creator_name 
                                                            /* select my friends' friends excluding me*/
															 from relation
															 where (to_user in (select to_user
																				from relation
																				where from_user = client_name
																				union all 
																				select from_user
																				from relation
																				where to_user = client_name)) 
																	/* one person in relationship should be one of my direct friends*/
																	and from_user <> client_name 
                                                                    /* discard the query result that returns myself*/
																	and to_view_priority >= 1 )  ) as F_FOF_result)
					  and posting.post_view_priority>=3 
                      /* this profile's viewing priority should be anyone*/
					  and location_post_like.like_user_name in (select to_user
																from relation
																where from_user = client_name
																union all 
																select from_user
																from relation
																where to_user = client_name)
					  and location_post_like.like_time >= ( select lasttime_access from user_info where user_name = client_name ) 
                      order by like_time desc, like_user_name asc)/*;*/
		) as all_search_result
         order by new_item_time desc);
        
end
delimiter ;

/*call see_liked_location( 'chelseaisgood' );*/