create view FOF_result( creator_name ) as 
(select to_user # select my friends' friends excluding me
 from relation
 where (from_user in (select to_user
						 from relation
						 where from_user = 'Terminator'
						 union all 
						 select from_user
						 from relation
						 where to_user = 'Terminator')) # one person in relationship should be one of my direct friends
	    and
	    (to_user not in (select to_user
					 from relation
					 where from_user = 'Terminator'
					 union all 
					 select from_user
					 from relation
					 where to_user = 'Terminator')) # the other one should be someone who is not a friend of mine
	    and to_user <> 'Terminator' # discard the query result that returns myself
	    and from_view_priority >= 1 ) # the friendship that your friend would like to show to his friends
 union
 (
 select from_user # select my friends' friends excluding me
 from relation
 where (to_user in (select to_user
					from relation
					where from_user = 'Terminator'
					union all 
					select from_user
					from relation
					where to_user = 'Terminator')) # one person in relationship should be one of my direct friends
	   and
	   (from_user not in (select to_user
						  from relation
						  where from_user = 'Terminator'
						  union all 
						  select from_user
						  from relation
						  where to_user = 'Terminator')) # the other one should be someone who is not a friend of mine
	   and from_user <> 'Terminator' # discard the query result that returns myself
	   and to_view_priority >= 1 ) ;