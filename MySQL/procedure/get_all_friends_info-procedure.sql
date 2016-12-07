delimiter ||
/*drop procedure if exists get_all_friends_info*/
create procedure get_all_friends_info ( in searcher_name varchar(20), in view_page_owner varchar(20) )
begin
	call DefineTheRelation( searcher_name, view_page_owner, @result);
	if searcher_name = view_page_owner then
		select *
        from ((select to_user as user_name
			   from relation
		       where from_user = view_page_owner)
               union all
			  (select from_user as user_name
			   from relation
			   where to_user = view_page_owner)) as friends_output natural left join user_profile
		order by user_name asc;
               
	elseif @result = 1 then
		select *
        from ((select to_user as user_name
			   from relation
		       where from_user = view_page_owner and from_view_priority >= 1)
               union all
			  (select from_user as user_name
			   from relation
			   where to_user = view_page_owner and to_view_priority >= 1)) as FOF_output natural left join user_profile
		order by user_name asc;
                       
	elseif @result = 2 then
		select *
        from ((select to_user as user_name
			   from relation
		       where from_user = view_page_owner and from_view_priority >= 2)
               union all
			  (select from_user as user_name
			   from relation
			   where to_user = view_page_owner and to_view_priority >= 2)) as FOFOF_output natural left join user_profile
		order by user_name asc;
                       
	else
		select *
        from ((select to_user as user_name
			   from relation
		       where from_user = view_page_owner and from_view_priority >= 3)
               union all
			  (select from_user as user_name
			   from relation
			   where to_user = view_page_owner and to_view_priority >= 3)) as anyone_output natural left join user_profile
		order by user_name asc;
                       
    end if;
end
delimiter ;