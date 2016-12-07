delimiter ||
/*drop procedure if exists procedure search_posting_keyword*/
create procedure get_one_all_posting ( in get_user_name varchar(20), in give_user_name varchar(20) )
begin
    call DefineTheRelation(get_user_name, give_user_name, @define_result);
    select *
    from posting natural left join link natural left join location
    where creator_name = give_user_name and @define_result <= post_view_priority
    order by P_time desc;
end
delimiter ;

/*
select *
from posting
where textfile like (@keyword) and (P_time between @starttime_timestamp and current_timestamp()) 
	and post_view_prioirty >= (select * from (call DefineTheRelation(search_username, creator_name, @result)))
order by P_time desc;
*/

/*
call search_posting_keyword( 'began', 'Yujia Zhai', 3, 'Last year' );
call search_posting_keyword( 'I', 'chelseaisgood', 3, 'Last seven days' );
call search_posting_keyword( 'I', 'chelseaisgood', 3, 'Last month' );
call search_posting_keyword( 'I', 'chelseaisgood', 3, 'Last year' );
select *
from posting;
*/