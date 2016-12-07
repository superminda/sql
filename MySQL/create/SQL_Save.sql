/* This is a query that user uses to sign up */
INSERT INTO user_info VALUES ('test_user', 'mf3308@nyu.edu', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('chelseaisgood', 'mf3308@nyu.edu', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Sirius_Black', 'chelseaisgoodfmd@gmail.com','aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Frank Lampard', '741959594@qq.com', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('John Terry', '1441034280@qq.com','aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Juan Mata', '2234957003@qq.com', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Atlético Madrid', 'ys61@nyu.edu', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Titanic', '10112110140@ecnu.cn', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Man from the Stars', 'chelseaisgood@qq.com', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Terminator', '10112110140@ecnu.cn', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('Yujia Zhai', 'yz3100@nyu.edu', 'aabbccdd', current_timestamp() );

select * from user_info;
/* ========================================================================================================= */


/* This is a query that user uses to create his profile */
INSERT INTO user_profile VALUES ('test_user', 'Minda', 'Fang', '2016-04-01', 'Brooklyn', 'Male', 
	LOAD_FILE('g:/618818.jpg'), current_timestamp(), 'I like cook by myself. I really love chinese food.', 3);
/*============================================================================================*/


/* This is a query that user uses to update his profile */
update user_profile set residence = 'Queens', date_of_birth= '2001-06-01', edit_time = current_timestamp() where user_name = 'test_user';
/*============================================================================================*/


/*posting a new post*/
set @new_ID = (select max(P_id) from posting )+1;
select @new_ID;

INSERT INTO posting VALUES (@new_ID, 'chelseaisgood', '2016-04-01 10:28:00', 'Eating Well in NYC(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 3, 0 );
/*    
INSERT INTO posting VALUES (1, 'test_user', '2016-04-02 17:31:00', 'Eating Well in NYC', 
	'This is my favourite food.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 3, 0 );
*/
select * from posting;
/*============================================================================================*/


#INSERT INTO location VALUES (1, 'Times Square', 'New York City', 'NY', '40.758899', '-73.9873197', 'chelseaisgood');  
/*
INSERT INTO relation_history VALUES ('test_user', 'Yujia Zhai', '2016-04-01 00:30:00', 0);
INSERT INTO relation VALUES ('chelseaisgood', 'Sirius_Black', 3, 3, '2016-04-01 01:00:00');
INSERT INTO relation VALUES ('Frank Lampard', 'chelseaisgood', 3, 3, '2016-04-01 03:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'John Terry', 3, 3, '2016-04-01 05:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Juan Mata', 3, 3, '2016-04-01 07:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Atlético Madrid', 3, 3, '2016-04-01 09:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Titanic', 3, 3, '2016-04-01 11:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Man from the Stars', 3, 3, '2016-04-01 13:00:00');
#INSERT INTO relation VALUES ('chelseaisgood', 'Terminator', 3, 3, '2016-04-01 15:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Yujia Zhai', 3, 3, '2016-04-01 17:00:00');
*/
       
/*================add a stranger as his friend================*/
#set @user_temp_1= 'chelseaisgood', @user_temp_2 = 'Sirius_Black';
set @user_temp_1= 'chelseaisgood', @user_temp_2 = 'Terminator';
INSERT INTO relation_history select @user_temp_1, @user_temp_2, current_timestamp(), 0 
From dual
where NOT EXISTS (select * from relation_history where from_user= @user_temp_1 and to_user= @user_temp_2 and friend_status = 0) and 
      not exists ((select from_user as result
				   from relation
				   where to_user = @user_temp_1 and from_user = @user_temp_2)
				   union all
				  (select to_user as result
				   from relation
				   where from_user = @user_temp_1 and to_user = @user_temp_2));
select * from relation_history;
/*============================================================================================*/ 
                
/*================accept a friend request================*/      

select * from relation;
select * from relation_history;
             
set SQL_SAFE_UPDATES = 0;  
set @reply_user_temp= 'Terminator', @request_user_temp = 'chelseaisgood';
update relation_history set friend_status = 1, time_request = current_timestamp() where (to_user = @reply_user_temp and from_user = @request_user_temp and friend_status = 0) ;
set SQL_SAFE_UPDATES = 1;  

select * from relation;
select * from relation_history;
/*============================================================================================*/ 



/*================select all my friends================*/
set @user_name = 'chelseaisgood';
select *
from(
		(select to_user as my_friends
		from relation
		where from_user = @user_name)
		union
		(select from_user as my_friends
		from relation
		where to_user = @user_name)
	) as lists_of_myfriends
order by my_friends asc;
/*============================================================================================*/ 

/*=========================select all FOF=========================*/
set @user_name = 'chelseaisgood';
select *
from(	(select to_user as FOF# select my friends' friends excluding me
		from relation
		where (from_user in (select to_user
							 from relation
							 where from_user = @user_name
							 union all 
							 select from_user
							 from relation
							 where to_user = @user_name)) # one person in relationship should be one of my direct friends
			  and
			  (to_user not in (select to_user
							   from relation
							   where from_user = @user_name
							   union all 
							   select from_user
							   from relation
							   where to_user = @user_name)) # the other one should be someone who is not a friend of mine
			   and to_user <> @user_name # discard the query result that returns myself
			   and from_view_priority >= 1) # the friendship that your friend would like to show to his friends
		union
		(select from_user as FOF # select my friends' friends excluding me
		from relation
		where (to_user in (select to_user
						   from relation
						   where from_user = @user_name
						   union all 
						   select from_user
						   from relation
						   where to_user = @user_name)) # one person in relationship should be one of my direct friends
			  and
			  (from_user not in (select to_user
								 from relation
								 where from_user = @user_name
								 union all 
								 select from_user
								 from relation
								 where to_user = @user_name)) # the other one should be someone who is not a friend of mine
			   and from_user <> @user_name # discard the query result that returns myself
			   and to_view_priority >= 1) # the friendship that your friend would like to show to his friends
		union # union friends of friends with all my friends
		(select user_name # select all my friends
		from user_info
		where (user_name in (select to_user
							 from relation
							 where from_user = @user_name
							 union all 
							 select from_user
							 from relation
							 where to_user = @user_name))) ) as FOF
order by FOF asc;
/*============================================================================================*/ 
							  

/*Output all friends' profile that the user can actually see, which contains keywork "hamburger"*/ 
set @user_name = 'chelseaisgood';
set @keyword = '%hamburger%';
select *
from user_profile
where (user_name in (select to_user
					 from relation
					 where from_user = @user_name
					 union all 
					 select from_user
					 from relation
					 where to_user = @user_name))
	   and biography like (@keyword) # seaching the specific keywords
	   and profile_view_priority >= 1 # the view_priority should allow at least their friends to se
order by user_name asc;
/*============================================================================================*/ 
	   
/*Output all friends' posting that the user can actually see, which contains keywork "hamburger"*/ 
select *
from posting
where (creator_name in (select to_user
					    from relation
					    where from_user = 'chelseaisgood'
					    union all 
					    select from_user
					    from relation
					    where to_user = 'chelseaisgood'))
	   and textfile like ('%hamburger%') # seaching the specific keywords
	   and view_priority >= 1; # the view_priority should allow at least their friends to see    
       
       

/*===========find all FOFs' posting which containing keyword "healthy" ===========*/
set @user_name = 'Terminator';
set @keyword = '%healthy%';
select *
from (
		(select posting.*
		from	(  (select to_user as creator_name  /* select friends of my friends excluding me */
					from relation
					where (from_user in (select to_user
										 from relation
										 where from_user = @user_name
										 union all 
										 select from_user
										 from relation
										 where to_user = @user_name)) /* one person in relationship should be one of my direct friends*/
					and
					(to_user not in (select to_user
									 from relation
									 where from_user = @user_name
									 union all 
									 select from_user
									 from relation
									 where to_user = @user_name)) /* the other one should be someone who is not a friend of mine */
					and to_user <> @user_name   /*discard the query result that returns myself */
					and from_view_priority >= 1 ) /* the friendship that your friend would like to show to his friends */
				union
				(select from_user as creator_name /* select my friends' friends excluding me*/
				 from relation
				 where (to_user in (select to_user
									from relation
									where from_user = @user_name
									union all 
									select from_user
									from relation
									where to_user = @user_name)) /*  one person in relationship should be one of my direct friends */
					   and
					   (from_user not in (select to_user
										  from relation
										  where from_user = @user_name
										  union all 
										  select from_user
										  from relation
										  where to_user = @user_name)) /*  the other one should be someone who is not a friend of mine*/
					   and from_user <> @user_name /* discard the query result that returns myself */
					   and to_view_priority >= 1 )  ) as FOF_result, posting
		where FOF_result.creator_name = posting.creator_name and post_view_priority>=2 and textfile like (@keyword) ) /* seaching the specific keywords*/

		union

		(select *
		 from posting
		 where (creator_name in (select to_user
								 from relation
								 where from_user = @user_name
								 union all 
								 select from_user
								 from relation
								 where to_user = @user_name))
			   and textfile like (@keyword) /* seaching the specific keywords */
			   and post_view_priority >= 1 ) ) as final_result /* the view_priority should allow at least their friends to see */
order by P_time desc;
 /*============================================================================================*/       
       
       
       
       
/*===========find all FOFs' profile which containing keyword "healthy" ===========*/
set @user_name = 'Yujia Zhai';
set @keyword = '%I%';
(select user_profile.*
from	(  (select to_user as creator_name # select my friends' friends excluding me
		    from relation
		    where (from_user in (select to_user
							     from relation
							     where from_user = @user_name
								 union all 
							     select from_user
							     from relation
							     where to_user = @user_name)) # one person in relationship should be one of my direct friends
			and
			(to_user not in (select to_user
						     from relation
						     where from_user = @user_name
						     union all 
						     select from_user
						     from relation
						     where to_user = @user_name)) # the other one should be someone who is not a friend of mine
			and to_user <> @user_name # discard the query result that returns myself
			and from_view_priority >= 1 ) # the friendship that your friend would like to show to his friends
		union
		(select from_user as creator_name # select my friends' friends excluding me
		 from relation
		 where (to_user in (select to_user
						    from relation
						    where from_user = @user_name
						    union all 
						    select from_user
						    from relation
						    where to_user = @user_name)) # one person in relationship should be one of my direct friends
			   and
			   (from_user not in (select to_user
								  from relation
								  where from_user = @user_name
								  union all 
								  select from_user
								  from relation
								  where to_user = @user_name)) # the other one should be someone who is not a friend of mine
			   and from_user <> @user_name # discard the query result that returns myself
			   and to_view_priority >= 1 )  ) as FOF_result, user_profile
where FOF_result.creator_name = user_profile.user_name and user_profile.profile_view_priority>=2 and user_profile.biography like (@keyword) )# seaching the specific keywords;

union

(select *
 from user_profile
 where (user_name in (select to_user
					  from relation
					  where from_user = @user_name
					  union all 
					  select from_user
					  from relation
					  where to_user = @user_name))
	   and biography like (@keyword) # seaching the specific keywords
	   and profile_view_priority >= 1 ); # the view_priority should allow at least their friends to see
       


       
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
/*============================================================================================*/       




/*===========find all people's profile which containing keyword "healthy" ===========*/
set @user_name = 'Terminator';
set @keyword = '%I%';

(select *
 from user_profile
 where (user_name in (select to_user
					     from relation
					     where from_user = @user_name
					     union all 
					     select from_user
					     from relation
						 where to_user = @user_name))
	   and biography like (@keyword) # seaching the specific keywords
	   and profile_view_priority >= 1 ) # the view_priority should allow at least their friends to see
 
union      

(select user_profile.*
from	(  (select to_user as creator_name # select my friends' friends excluding me
		    from relation
		    where (from_user in (select to_user
							     from relation
							     where from_user = @user_name
								 union all 
							     select from_user
							     from relation
							     where to_user = @user_name)) # one person in relationship should be one of my direct friends
			and
			(to_user not in (select to_user
						     from relation
						     where from_user = @user_name
						     union all 
						     select from_user
						     from relation
						     where to_user = @user_name)) # the other one should be someone who is not a friend of mine
			and to_user <> @user_name # discard the query result that returns myself
			and from_view_priority >= 1 ) # the friendship that your friend would like to show to his friends
		union
		(select from_user as creator_name # select my friends' friends excluding me
		 from relation
		 where (to_user in (select to_user
						    from relation
						    where from_user = @user_name
						    union all 
						    select from_user
						    from relation
						    where to_user = @user_name)) # one person in relationship should be one of my direct friends
			   and
			   (from_user not in (select to_user
								  from relation
								  where from_user = @user_name
								  union all 
								  select from_user
								  from relation
								  where to_user = @user_name)) # the other one should be someone who is not a friend of mine
			   and from_user <> @user_name # discard the query result that returns myself
			   and to_view_priority >= 1 )  ) as FOF_result, user_profile
where FOF_result.creator_name = user_profile.user_name and profile_view_priority>=2 and biography like (@keyword) )# seaching the specific keywords;

union

(select user_profile.*
 from user_profile
 where user_name not in( select *
                            from ( (select to_user as creator_name # select my friends' friends excluding me
		                            from relation
									where (from_user in (select to_user
							                             from relation
							                             where from_user = @user_name
								                         union all 
							                             select from_user
							                             from relation
														 where to_user = @user_name) ) # one person in relationship should be one of my direct friends
			                               and
			                              (to_user not in (select to_user
						                                   from relation
						                                   where from_user = @user_name
						                                   union all 
						                                   select from_user
														   from relation
						                                   where to_user = @user_name)) # the other one should be someone who is not a friend of mine
										   and to_user <> @user_name # discard the query result that returns myself
			                               and from_view_priority >= 1 ) # the friendship that your friend would like to show to his friends
								    union
		                            (select from_user as creator_name # select my friends' friends excluding me
									 from relation
		                             where (to_user in (select to_user
						                                from relation
														where from_user = @user_name
						                                union all 
						                                select from_user
						                                from relation
						                                where to_user = @user_name)) # one person in relationship should be one of my direct friends
											and
	                                        (from_user not in (select to_user
						                                       from relation
						                                       where from_user = @user_name
						                                       union all 
						                                       select from_user
						                                       from relation
						                                       where to_user = @user_name)) # the other one should be someone who is not a friend of mine
									        and from_user <> @user_name # discard the query result that returns myself
	                                        and to_view_priority >= 1 )  ) as FOF_result)
      and profile_view_priority>=3 # this profile's viewing priority should be anyone
      and biography like (@keyword) );



/*Output all friends' posting during last week*/ 
set @user_name = 'chelseaisgood';

# set the search_starttime 
set @day_number = 10;
set @starttime_date = (SELECT DATE_SUB(current_date(), INTERVAL (@day_number-1) DAY));     
set @starttime_timestamp = CONCAT(@starttime_date, " 00:00:00"); #convert date into timestamp type
select @starttime_timestamp;
    
select *
from posting
where (creator_name in (select to_user
					    from relation
					    where from_user = @user_name
					    union all 
					    select from_user
					    from relation
					    where to_user = @user_name))
	   and P_time >= ( @starttime_timestamp )
	   and post_view_priority >= 1 /* the view_priority should allow at least their friends to see */
order by P_time desc;
/*============================================================================================*/       


/*list all the location liked by friends*/ 
set @user_name = 'chelseaisgood';
select location.L_name, location_post_like.*, posting.creator_name
from location_post_like natural join posting natural join location
where (like_user_name in (select to_user
					      from relation
					      where from_user = @user_name
					      union all 
					      select from_user
					      from relation
					      where to_user = @user_name) )
order by like_time desc;
/*============================================================================================*/ 