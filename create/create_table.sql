
DROP TABLE link;
DROP TABLE bulletin_comments;
DROP TABLE post_comments;
DROP TABLE location_post_like;
DROP TABLE post_like;
DROP TABLE posting;
DROP TABLE location;
DROP TABLE relation_history;
DROP TABLE relation;
DROP TABLE user_profile;
DROP TABLE user_info;

create table user_info (
	user_name varchar ( 20 ),
	email varchar(40) not null,
	pwd  varchar(10) not null,
	lasttime_access timestamp not null,
  	primary key ( user_name ) );


create table user_profile (
	user_name varchar ( 20 ),
	first_name varchar ( 20 ) not null,
	last_name varchar ( 20 ) not null,
  	date_of_birth date,
	residence varchar(20),
	gender enum('Male', 'Female', 'Other'),
	pic mediumblob,
	edit_time timestamp,
	biography text,
	profile_view_priority tinyint,  
  	primary key ( user_name ), 
    foreign key ( user_name ) references user_info( user_name ));
 /*profile_view_priority enum('Me', 'Friends', 'FOF', 'ALL')  */

create table relation (
	from_user varchar ( 20 ) not null, 
	to_user varchar ( 20 ) not null,
	from_view_priority tinyint not null DEFAULT 1,
    to_view_priority tinyint not null DEFAULT 1,
	time_start timestamp,
  	primary key ( from_user, to_user ),
	foreign key ( from_user ) references user_info( user_name ),
	foreign key ( to_user ) references user_info( user_name ));


create table relation_history (
	from_user varchar ( 20 ), 
	to_user varchar ( 20 ),
	time_request timestamp,
	friend_status tinyint,
  	primary key ( from_user, to_user, time_request ),
	foreign key ( from_user ) references user_info( user_name ),
   	foreign key ( to_user ) references user_info( user_name ) );

    
create table location (
	L_id varchar ( 20 ) not null, 
	L_name varchar ( 20 ) not null,
    city varchar(20),
    state varchar (5),
	longitude  varchar( 15 ),
	latitude varchar( 15 ),
    loc_creator_name varchar ( 20 ),
	primary key ( L_id ),
    foreign key ( loc_creator_name ) references user_info( user_name ));
    

create table posting (
	P_id varchar ( 20 ),
	creator_name varchar ( 20 ) not null, 
	P_time timestamp not null,
	title  varchar( 30 ),
	textfile text,	
	image mediumblob,
	video LongBlob,
	post_view_priority tinyint,
	#P_type enum ('diary','profile','news'),
	like_num int(8) not null DEFAULT 0,
	primary key ( P_id ),
	foreign key ( creator_name ) references user_info( user_name ));


create table post_like (
	P_id varchar ( 20 ),
	like_user_name varchar ( 20 ), 
	like_time timestamp,
	primary key ( P_id, like_user_name),
	foreign key ( like_user_name ) references user_info( user_name ),
    foreign key ( P_id ) references posting( P_id ));


create table location_post_like (
	L_id varchar ( 20 ),
	P_id varchar ( 20 ),
	like_user_name varchar ( 20 ), 
	like_time timestamp,
	primary key ( L_id, P_id, like_user_name),
	foreign key ( L_id ) references location( L_id ),
	foreign key ( P_id ) references posting( P_id ),
	foreign key ( like_user_name ) references user_info( user_name ));


create table post_comments (
	P_id varchar ( 20 ),
	comment_time timestamp,
	from_user_name varchar ( 20 ), 
	to_user_name varchar ( 20 ) not null,
	comment_content text,
	primary key ( P_id, comment_time, from_user_name ),
    foreign key ( P_id ) references posting ( P_id ),
	foreign key ( from_user_name ) references user_info( user_name ),
	foreign key ( to_user_name ) references user_info( user_name ));
    
create table bulletin_comments (
	user_name varchar ( 20 ),
	comment_time timestamp,
	from_user_name varchar ( 20 ), 
	to_user_name varchar ( 20 ) not null,
	comment_content text,
	primary key ( user_name, comment_time, from_user_name ),
    foreign key ( user_name ) references user_info ( user_name ),
	foreign key ( from_user_name ) references user_info( user_name ),
	foreign key ( to_user_name ) references user_info( user_name ));
    

create table link (
	P_id varchar ( 20 ),
	L_id varchar ( 20 ),
	primary key ( P_id ),
    foreign key ( P_id ) references posting ( P_id ),
    foreign key ( L_id ) references location ( L_id )	);
