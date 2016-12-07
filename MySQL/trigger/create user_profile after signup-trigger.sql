delimiter ||
create trigger add_user_profile after insert on user_info
for each row
begin
	insert INTO user_profile values( new.user_name, null, null, null, null, null, null, current_timestamp(), null, 1 );
end||
delimiter ;