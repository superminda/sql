delimiter ||
create procedure update_photo_addr ( in photo_user varchar(20) )
begin
	if photo_user in ( select user_name from user_profile) then
		set @photoaddr= CONCAT('http://localhost/Project/Media/userphoto/', photo_user, '.png');
		update user_profile set edit_time = current_timestamp() where user_name = photo_user;
        update user_profile set pic = @photoaddr where user_name = photo_user;
		select true as photo_update_result from dual;
	else
		select false as photo_update_result from dual;
	end if;
end
delimiter ;

/*set @photo_user = 'chelseaisgood';
set @photoaddr= CONCAT('../Media/userphoto/', @photo_user, '.png');

select @photoaddr from dual;*/