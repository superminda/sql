delimiter ||
create procedure new_posting ( in in_creator_name varchar(20), 
                               in in_title varchar(30), 
                               in in_textfile text, 
                               in in_image mediumblob, 
                               in in_video LongBlob,
                               in in_post_view_priority tinyint, 
                               in in_L_name varchar ( 40 ),
                               in in_city varchar(40), 
                               in in_state varchar(5),
                               in in_longitude varchar( 15 ), 
                               in in_latitude varchar( 15 ))

begin
	if (in_L_name <> '') then
		call ifnew_location (in_L_name, in_city, in_state, in_longitude, in_latitude, in_creator_name, @out_L_id);
	end if;
    call add_posting (in_creator_name, in_title, in_textfile, in_image, in_video, in_post_view_priority, @out_P_id);
	if (in_L_name <> '') then
		insert into link values (@out_P_id, @out_L_id);
	end if;
	  select @out_P_id as new_posting_result from dual; 
end
delimiter ;