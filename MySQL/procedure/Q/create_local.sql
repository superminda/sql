DROP TABLE comments;
DROP TABLE like_choice;
DROP TABLE posting;
DROP TABLE location;
DROP TABLE relation_history;
DROP TABLE relation;
DROP TABLE user_info;

create table user_info (
	user_name varchar ( 20 ),
	first_name varchar ( 20 ) not null,
	last_name varchar ( 20 ) not null,
  	date_of_birth date,
	email varchar(40) not null,
	residence varchar(20),
	gender enum('Male', 'Female', 'Other'),
	pic mediumblob,
	pwd  varchar(10) not null,
	lasttime_access timestamp not null,
	edit_time timestamp,
	biography text,
	view_priority tinyint,  
  	primary key ( user_name ) );
/*
INSERT INTO user_info VALUES ('chelseaisgood', 'Minda', 'Fang', '2016-04-01', 'mf3308@nyu.edu', 'Brooklyn', 'Male', LOAD_FILE('g:/618818.jpg'), 'aabbccdd', current_timestamp(), current_timestamp(), 'I like cook by myself. I really love chinese food.', 3);
INSERT INTO user_info VALUES ('Sirius_Black', 'Frank', 'Fang', '2016-01-01', 'chelseaisgoodfmd@gmail.com', 'Shanghai', 'Male', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I love go to the restaurant. I enjoy fried chicken.', 3);
INSERT INTO user_info VALUES ('Frank Lampard', 'Frank', 'Lampard', '1978-06-20', '741959594@qq.com', 'New York', 'Male', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I love to eat in New York. I often go to Chinatown and enjoy the food there.', 3);
INSERT INTO user_info VALUES ('John Terry', 'John', 'Terry', '1980-12-07', '1441034280@qq.com', 'London', 'Male', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I love to eat in London. My favourite food is fish and chips.', 2);
INSERT INTO user_info VALUES ('Juan Mata', 'Juan', 'Mata', '1988-04-28', '2234957003@qq.com', 'Manchester', 'Male', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I live in Manchester. Quill restaurant is headed up by Curtis Stewart and the menu has been described as modern British cuisine, with European influences. I love there best', 2);
INSERT INTO user_info VALUES ('Atlético Madrid', 'Fernando', 'Torres', '1984-03-20', 'ys61@nyu.edu', 'Madrid', 'Male', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'The most popular and well known dishes of Spanish gastronomy: paella, spanish tortilla, gazpacho, Spanish desserts.', 2);
INSERT INTO user_info VALUES ('Titanic', 'Kate', 'Winslet', '1975-10-05', '10112110140@ecnu.cn', 'Berkshire', 'Other', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I love cream~', 1);
INSERT INTO user_info VALUES ('Man from the Stars', 'Soo-hyun', 'Kim', '1988-02-16', 'chelseaisgood@qq.com', 'Seoul', 'Male', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I recommend Samgyetang.', 1);
INSERT INTO user_info VALUES ('Terminator', 'Arnold', 'Schwarzenegger', '1947-07-30', '10112110140@ecnu.cn', 'Brooklyn', 'Other', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I love ham!.', 1);
INSERT INTO user_info VALUES ('Yujia Zhai', 'Yujia', 'Zhai', '1992-12-31', 'yz3100@nyu.edu', 'Brooklyn', 'Female', null, 'aabbccdd', current_timestamp(), current_timestamp(), 'I love hamburger!.', 0);
*/

create table relation (
	from_user varchar ( 20 ) not null, 
	to_user varchar ( 20 ) not null,
	from_view_priority tinyint, 
	to_view_priority tinyint,
	time_start timestamp,
  	primary key ( from_user, to_user ),
    foreign key ( from_user ) references user_info( user_name ),
    foreign key ( to_user ) references user_info( user_name ));
    
INSERT INTO relation VALUES ('chelseaisgood', 'Sirius_Black', 3, 3, '2016-04-01 01:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Frank Lampard', 3, 3, '2016-04-01 03:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'John Terry', 3, 3, '2016-04-01 05:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Juan Mata', 3, 3, '2016-04-01 07:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Atlético Madrid', 3, 3, '2016-04-01 09:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Titanic', 3, 3, '2016-04-01 11:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Man from the Stars', 3, 3, '2016-04-01 13:00:00');
#INSERT INTO relation VALUES ('chelseaisgood', 'Terminator', 3, 3, '2016-04-01 15:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Yujia Zhai', 3, 3, '2016-04-01 17:00:00');

create table relation_history (
	from_user varchar ( 20 ), 
	to_user varchar ( 20 ),
	time_request timestamp,
	friend_status tinyint,
  	primary key ( from_user, to_user, time_request ),
	foreign key ( from_user ) references user_info( user_name ),
   	foreign key ( to_user ) references user_info( user_name ) );

INSERT INTO relation_history VALUES ('chelseaisgood', 'Sirius_Black', '2016-04-01 00:28:00', 0);
INSERT INTO relation_history VALUES ('chelseaisgood', 'Sirius_Black', '2016-04-01 00:30:00', 1);
    
create table location (
	L_id varchar ( 20 ) not null, 
	L_name varchar ( 20 ) not null,
    city varchar(20),
    state varchar (5),
	longitude  varchar( 15 ),
	latitude varchar( 15 ),
	primary key ( L_id ) );
    
INSERT INTO location VALUES (1, 'Times Square', 'New York City', 'NY', '40.758899', '-73.9873197');  


create table posting (
	P_id varchar ( 20 ),
	creator_name varchar ( 20 ) not null, 
	P_time timestamp not null,
	title  varchar( 20 ),
	textfile text,	
	image mediumblob,
	video LongBlob,
	view_priority tinyint,
	L_id varchar ( 20 ),
	#P_type enum ('diary','profile','news'),
	like_num int(8),
	primary key ( P_id ),
	foreign key ( creator_name ) references user_info( user_name ));

INSERT INTO posting VALUES (1, 'chelseaisgood', '2016-04-01 10:28:00', 'Eating Well in NYC', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/health-guru-names-his-8-favorite-restaurants-in-nyc.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 3, 1, 20 );
    

create table like_choice (
	item_id varchar ( 20 ),
	like_user_name varchar ( 20 ), 
	like_type varchar( 4 ),
	like_time timestamp,
	primary key ( item_id, like_user_name, like_type),
	foreign key ( like_user_name ) references user_info( user_name ));
    
INSERT INTO like_choice VALUES ( 1, 'Sirius_Black', 'Post', '2016-04-01 11:28:00');  

create table comments (
	C_id varchar ( 20 ),
	item_id varchar ( 20 ) not null, 
	comment_time timestamp not null,
	from_user_name varchar ( 20 ) not null, 
	to_user_name varchar ( 20 ) not null,
	comment_content text,
	primary key ( C_id ),
	foreign key ( from_user_name ) references user_info( user_name ),
	foreign key ( to_user_name ) references user_info( user_name ));

INSERT INTO comments VALUES ( 1, 1, '2016-04-01 11:38:00', 'Sirius_Black', 'chelseaisgood', 'Nice food. Hope I can go there next time!'); 
INSERT INTO comments VALUES ( 2, 'chelseaisgood', '2016-04-01 11:37:00', 'Sirius_Black', 'chelseaisgood', 'Happy Birthday!');   

#update user_info set pic = LOAD_FILE('g:/download.jpg') where user_name = 'chelseaisgood';



