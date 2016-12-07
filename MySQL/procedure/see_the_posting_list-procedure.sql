delimiter ||
/*drop procedure if exists see_the_profile*/
create procedure see_the_posting_list ( in user_name varchar(20), in view_page_owner varchar(20) )
begin
	call DefineTheRelation( user_name, view_page_owner, @result);
	if user_name = view_page_owner then
		select P_id, title, P_time
        from posting
        where posting.creator_name = view_page_owner
        order by P_time desc;
               
	elseif @result = 1 then
		select P_id, title, P_time
        from posting
        where posting.creator_name = view_page_owner and posting.post_view_priority >= 1
        order by P_time desc;
                       
	elseif @result = 2 then
		select P_id, title, P_time
        from posting
        where posting.creator_name = view_page_owner and posting.post_view_priority >= 2
        order by P_time desc;
                       
	else
		select P_id, title, P_time
        from posting
        where posting.creator_name = view_page_owner and posting.post_view_priority >= 3
        order by P_time desc;
                       
    end if;
end
delimiter ;

/*call see_the_posting_list (  'chelseaisgood', 'Yujia Zhai' )*/
/*call see_the_posting_list (   'Terminator' , 'chelseaisgood')*/
/*call see_the_posting_list (  'Yujia Zhai', 'Terminator' )*/