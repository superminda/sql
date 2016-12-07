delimiter ||
"drop procedure if exists see_the_profile"
create procedure check_new_items ( in client_name varchar(20) )
begin
	select *
    from (
			"alert new comments on your bulletin board"
			(select from_user_name as people, 'leave_message' as new_item_type, comment_time as new_item_time, 
				comment_content as new_item_content, to_user_name as link_addr, to_user_name as carrier_name
			 from bulletin_comments
			 where to_user_name = client_name
				 and comment_time >= (select lasttime_access from user_info where user_name = client_name )
			 order by new_item_time desc)
			
			union
			
            
			"alert new comments under your posts"
			(select from_user_name as people, 'leave_comment' as new_item_type, comment_time as new_item_time, 
				post_comments.comment_content as new_item_content, posting.P_id as link_addr, posting.title as carrier_name
			 from post_comments natural join posting
			 where posting.creator_name = client_name and from_user_name <> client_name
				 and comment_time >= (select lasttime_access from user_info where user_name = client_name )
			 order by new_item_time desc)
			
			union
			
            
			"alert new comments that replies your comment under other's post"
			(select from_user_name as people, 'reply_comment' as new_item_type, comment_time as new_item_time, 
				post_comments.comment_content as new_item_content, posting.P_id as link_addr, posting.title as carrier_name
			 from post_comments natural join posting
			 where posting.creator_name <> client_name and to_user_name = client_name
				 and comment_time >= (select lasttime_access from user_info where user_name = client_name )
			 order by new_item_time desc)
			
			union
			
			
			"alert new posts from your friends"
			(select creator_name as people, 'post' as new_item_type, P_time as new_item_time, 
				posting.title as new_item_content, posting.P_id as link_addr, posting.title as carrier_name
			 from posting
			 where (creator_name in (select to_user
									 from relation
									 where from_user = client_name
									 union all 
									 select from_user
									 from relation
									  where to_user = client_name))
					and P_time >= (select lasttime_access from user_info where user_name = client_name )
					and post_view_priority >= 1 " the view_priority should allow at least their friends to see)"
			  order by new_item_time desc)
			  
			union
			
            
			"alert new profile updated by your friends"
			(select user_name as people, 'update' as new_item_type, edit_time as new_item_time, 
				null as new_item_content, user_name as link_addr, user_name as carrier_name
			 from user_profile
			 where (user_name in (select to_user
								  from relation
								  where from_user = client_name
								  union all 
								  select from_user
								  from relation
								  where to_user = client_name))
					and edit_time >= (select lasttime_access from user_info where user_name = client_name )
					and profile_view_priority >= 1 " the view_priority should allow at least their friends to see)"
			  order by new_item_time desc)
				 
			union
			
            
			"alert new friend request"
			(select from_user as people, 'request' as new_item_type, time_request as new_item_time, 
				null as new_item_content, to_user as link_addr, to_user as carrier_name
			 from relation_history
			 where to_user = client_name and time_request >= (select lasttime_access from user_info where user_name = client_name ) 
				and friend_status = 0
			 order by new_item_time desc)
			 
			 union
			 
			 "celebrate new friendship"
			(select new_people as people, 'be_friend' as new_item_type, time_start as new_item_time, 
				null as new_item_content, new_people as link_addr, new_people as carrier_name
			 from (	(select to_user as new_people, time_start
					 from relation
					 where from_user = client_name and time_start >= (select lasttime_access from user_info where user_name = client_name ))
					union
					(select from_user as new_people, time_start
					 from relation
					 where to_user = client_name and time_start >= (select lasttime_access from user_info where user_name = client_name ))	) as new_friendship
			 order by new_item_time desc)
			 
			 union
			 
			 
			 "alert my locations liked by friends"
			(select location_post_like.like_user_name as people, 'like_loca' as new_item_type, location_post_like.like_time as new_item_time, 
				location.L_name as new_item_content, posting.P_id as link_addr, posting.title as carrier_name
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
				   "and posting.post_view_priority >= 0   the view_priority should allow at least their friends to see"
			 "order by location_post_like.like_time desc, location_post_like.like_user_name asc)"
			 order by new_item_time desc	)
			 
			 union
			 
             
			  "alert my posts liked by friends"
			(select post_like.like_user_name as people, 'like_post' as new_item_type, post_like.like_time as new_item_time, 
				posting.title as new_item_content, posting.P_id as link_addr, posting.title as carrier_name
			 from posting natural join post_like
			 where posting.creator_name =client_name
				   and post_like.like_user_name in (select to_user
													from relation
													where from_user = client_name
													union all 
													select from_user
													from relation
													where to_user = client_name)
				   and post_like.like_time >= ( select lasttime_access from user_info where user_name = client_name )
				   "and posting.post_view_priority >= 0   the view_priority should allow at least their friends to see
			 order by new_item_time desc)	)as new_items_listing"
	order by new_item_time desc;
        
end
delimiter ;



/*
call check_new_items( 'chelseaisgood' );

select *
from bulletin_comments;

select lasttime_access from user_info where user_name = @client_name;

select * from user_info;
*/