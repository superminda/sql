delimiter ||
/*drop procedure if two people are friends*/
create procedure insert_chat_data ( in user1_name varchar(20), in user2_name varchar(20), in message_content text)
begin
insert into bulletin_comments values (user1_name, user2_name, current_timestamp(),message_content);
        
end
delimiter ;