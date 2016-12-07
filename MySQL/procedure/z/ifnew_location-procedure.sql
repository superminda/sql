delimiter ||
create procedure ifnew_location ( in in_L_name varchar ( 40 ),in in_city varchar(40), in in_state varchar(5),in in_longitude varchar( 15 ), in in_latitude varchar( 15 ), in in_loc_creator_name varchar ( 20 ), out out_L_id varchar ( 20 ))
begin
	if exists ( select L_name from location 
                      where L_name=in_L_name and city=in_city and state=in_state and longitude = in_longitude and latitude=in_latitude) then
		set out_L_id = ( select L_id from location 
                      where L_name=in_L_name and city=in_city and state=in_state and longitude = in_longitude and latitude=in_latitude);
	else
		if (select count(*) from location) = 0 then
			set out_L_id = 1;
		else
			set out_L_id=( select L_id+1 from location order by CAST(L_id as SIGNED) desc limit 1);
		end if;
		insert into location values (out_L_id, in_L_name, in_city, in_state, in_longitude,in_latitude, in_loc_creator_name );
    end if;
end
delimiter ;