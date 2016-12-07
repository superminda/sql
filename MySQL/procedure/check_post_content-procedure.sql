delimiter ||
create procedure allinfo_post ( in post_id varchar(20) )
begin
	select *
    from posting natural left join link natural left join location
	where posting.P_id=post_id;
end
delimiter ;