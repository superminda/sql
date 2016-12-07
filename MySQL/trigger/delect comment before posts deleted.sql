delimiter ||
create trigger delect_all before delete on posting
for each row
begin
    DELETE FROM post_like where P_id = old.P_id ;
    DELETE FROM location_post_like where P_id = old.P_id ;
    DELETE FROM post_comments where P_id = old.P_id ;
    #DELETE FROM post_like where P_id= 1 and like_user_name ='Juan Mata' ;
end||
delimiter ;


/*
set SQL_SAFE_UPDATES = 0; 
DELETE FROM posting where P_id = 1;  
set SQL_SAFE_UPDATES = 1; 
*/