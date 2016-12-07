delimiter ||
create trigger update_edittime after update on user_profile
for each row
begin
	update user_profile set edit_time = current_timestamp();
end||
delimiter ;