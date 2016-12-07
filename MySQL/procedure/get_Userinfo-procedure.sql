-- delimiter ||
-- create procedure get_Userinfo ( in user_id varchar(20) )
-- begin
	-- select user_name, email, lasttime_access, first_name, last_name, date_of_birth, residence, gender, pic, biography
    -- from user_info natural left join user_profile
	-- where user_info.user_name=user_id;
-- end
-- delimiter ;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_Userinfo`( in user_id varchar(20) )
begin
	select user_name, email, lasttime_access, first_name, last_name, date_of_birth, residence, gender, pic, biography, profile_view_priority
    from user_info natural left join user_profile
	where user_info.user_name=user_id;
end