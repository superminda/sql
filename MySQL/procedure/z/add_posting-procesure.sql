delimiter ||
create procedure add_posting ( in in_creator_name varchar(20), in in_title varchar(30), in in_textfile text, in in_image mediumblob, in in_video LongBlob,in in_post_view_priority tinyint, out out_P_id varchar ( 20 ))
begin
    if (select count(P_id) from posting) = 0 then
        set out_P_id = 1;
    else
        set out_P_id=( select P_id+1 from posting order by CAST(P_id as SIGNED) desc limit 1);
    end if;
​
    insert into posting values (out_P_id, in_creator_name, current_timestamp(), in_title, in_textfile, in_image, in_video, in_post_view_priority, 0);
end
delimiter ;

/*
call add_posting ( 'chelseaisgood','My first day in NY', 'I am very happy', null, null, 3, @out_P_id);
select @out_P_id from dual;
*/