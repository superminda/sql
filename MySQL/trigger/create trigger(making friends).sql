/*
function:
1. create friendship record in the relation table after one user accept a friend request
*/

delimiter ||
create trigger add_friendship after update on relation_history
for each row
begin
	if new.friend_status = 1 then
		insert INTO relation values( new.from_user, new.to_user, 1, 1, current_timestamp() );
    end if;
end||
delimiter ;

/*

set SQL_SAFE_UPDATES = 0;  
set @reply_user_temp= 'Sirius_Black', @request_user_temp = 'chelseaisgood';
update relation_history set friend_status = 1, time_request = current_timestamp() where (to_user = @reply_user_temp and from_user = @request_user_temp and friend_status = 0) ;
set SQL_SAFE_UPDATES = 1;  

*/

/*


set SQL_SAFE_UPDATES = 0;  
INSERT INTO relation_history VALUES ('chelseaisgood', 'Sirius_Black', '2016-04-01 01:00:00', 0);
set SQL_SAFE_UPDATES = 1;  

*/