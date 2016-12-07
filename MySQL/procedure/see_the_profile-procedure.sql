delimiter ||
/*drop procedure if exists see_the_profile*/
create procedure see_the_profile ( in user_name varchar(20), in view_page_owner varchar(20) )
begin
	call DefineTheRelation( user_name, view_page_owner, @result);
	if user_name = view_page_owner then
		select *
        from user_profile
        where user_profile.user_name = view_page_owner;
               
	elseif @result = 1 then
		select *
        from user_profile
        where user_profile.user_name = view_page_owner and user_profile.profile_view_priority >= 1;
                       
	elseif @result = 2 then
		select *
        from user_profile
        where user_profile.user_name = view_page_owner and user_profile.profile_view_priority >= 2;
                       
	else
		select *
        from user_profile
        where user_profile.user_name = view_page_owner and user_profile.profile_view_priority >= 3;
                       
    end if;
end
delimiter ;

#call see_the_profile (  'chelseaisgood', 'Yujia Zhai' )
#call see_the_profile (  'chelseaisgood', 'Terminator' )
#call see_the_profile (  'Yujia Zhai', 'Terminator' )