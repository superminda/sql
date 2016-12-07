create procedure update_profile( in user_name varchar(20), in first_name varchar(20), 
								 in last_name varchar(20), in date_of_birth date, 
								 in residence varchar(20), in gender enum('Male', 'Female', 'Other'),
								 in biography text, in profile_view_priority tinyint(4))
begin
	update user_profile set    	user_profile.last_name = last_name,
								user_profile.first_name = first_name,
								user_profile.date_of_birth = date_of_birth,
								user_profile.residence = residence, 
								user_profile.gender = gender, 
								user_profile.biography = biography, 
								user_profile.profile_view_priority = profile_view_priority,
								user_profile.edit_time = current_timestamp()
	where user_profile.user_name = user_name;
end