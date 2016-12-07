delimiter ||
/*drop procedure if exists find_all_friends*/
create procedure find_all_friends ( in user_name varchar(20), in view_page_owner varchar(20) )
begin
	call DefineTheRelation( user_name, view_page_owner, @result);
	if user_name = view_page_owner then
		select *
        from ((select to_user as friend_list_output
			   from relation
		       where from_user = view_page_owner)
               union all
			  (select from_user as friend_list_output
			   from relation
			   where to_user = view_page_owner)) as friends_output;
               
	elseif @result = 1 then
		select *
        from ((select to_user as friend_list_output
			   from relation
		       where from_user = view_page_owner and from_view_priority >= 1)
               union all
			  (select from_user as friend_list_output
			   from relation
			   where to_user = view_page_owner and to_view_priority >= 1)) as FOF_output;
                       
	elseif @result = 2 then
		select *
        from ((select to_user as friend_list_output
			   from relation
		       where from_user = view_page_owner and from_view_priority >= 2)
               union all
			  (select from_user as friend_list_output
			   from relation
			   where to_user = view_page_owner and to_view_priority >= 2)) as FOFOF_output;
                       
	else
		select *
        from ((select to_user as friend_list_output
			   from relation
		       where from_user = view_page_owner and from_view_priority >= 3)
               union all
			  (select from_user as friend_list_output
			   from relation
			   where to_user = view_page_owner and to_view_priority >= 3)) as anyone_output;
                       
    end if;
end
delimiter ;

#call find_all_friends ( 'Yujia Zhai', 'chelseaisgood' )
#call find_all_friends ( 'Terminator', 'chelseaisgood' )
#call find_all_friends ( 'Harry Potter', 'chelseaisgood' )