delimiter ||
create procedure get_user_photo ( in U_id varchar(20) )
begin
	if (select pic from user_profile where user_name = U_id ) is null then
		select 'http://localhost/Project/face.png' as photo_addr from dual;
	else
        select concat('http://localhost/Project/Media/userphoto/',U_id,'.png.') as photo_addr from dual;
	end if;
end
delimiter ;

/*
call project.get_all_post_comments('4');
*/
