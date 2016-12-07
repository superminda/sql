INSERT INTO user_info VALUES ('test_user', 'mf3308@nyu.edu', 'aabbccdd', current_timestamp() );
INSERT INTO user_info VALUES ('chelseaisgood', 'mf3308@nyu.edu', 'aabbccdd', '2016-02-01 03:00:00');
INSERT INTO user_info VALUES ('Sirius_Black', 'chelseaisgoodfmd@gmail.com','aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Frank Lampard', '741959594@qq.com', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('John Terry', '1441034280@qq.com','aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Juan Mata', '2234957003@qq.com', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Atlético Madrid', 'ys61@nyu.edu', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Titanic', '10112110140@ecnu.cn', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Man from the Stars', 'chelseaisgood@qq.com', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Terminator', '10112110140@ecnu.cn', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Yujia Zhai', 'yz3100@nyu.edu', 'aabbccdd', current_timestamp());
INSERT INTO user_info VALUES ('Harry Potter', 'mf3308@nyu.edu', 'aabbccdd', current_timestamp());


INSERT INTO user_profile VALUES ('chelseaisgood', 'Minda', 'Fang', '2016-04-01', 'Brooklyn', 'Male', LOAD_FILE('g:/618818.jpg'), '2016-02-01 03:00:00', 'I like cook by myself. I really love chinese food.', 3);
INSERT INTO user_profile VALUES ('Sirius_Black', 'Frank', 'Fang', '2016-01-01', 'Shanghai', 'Male', null, current_timestamp(), 'I love go to the restaurant. I enjoy fried chicken.', 3);
INSERT INTO user_profile VALUES ('Frank Lampard', 'Frank', 'Lampard', '1978-06-20', 'New York', 'Male', null, current_timestamp(), 'I love to eat in New York. I often go to Chinatown and enjoy the food there.', 3);
INSERT INTO user_profile VALUES ('John Terry', 'John', 'Terry', '1980-12-07', 'London', 'Male', null, current_timestamp(), 'I love to eat in London. My favourite food is fish and chips.', 2);
INSERT INTO user_profile VALUES ('Juan Mata', 'Juan', 'Mata', '1988-04-28', 'Manchester', 'Male', null, current_timestamp(), 'I live in Manchester. Quill restaurant is headed up by Curtis Stewart and the menu has been described as modern British cuisine, with European influences. I love there best', 2);
INSERT INTO user_profile VALUES ('Atlético Madrid', 'Fernando', 'Torres', '1984-03-20', 'Madrid', 'Male', null, current_timestamp(), 'The most popular and well known dishes of Spanish gastronomy: paella, spanish tortilla, gazpacho, Spanish desserts.', 2);
INSERT INTO user_profile VALUES ('Titanic', 'Kate', 'Winslet', '1975-10-05', 'Berkshire', 'Other', null, current_timestamp(), 'I love cream~', 2);
INSERT INTO user_profile VALUES ('Man from the Stars', 'Soo-hyun', 'Kim', '1988-02-16', 'Seoul', 'Male', null, current_timestamp(), 'I recommend Samgyetang and hamburger.', 1);
INSERT INTO user_profile VALUES ('Terminator', 'Arnold', 'Schwarzenegger', '1947-07-30', 'California', 'Other', null, current_timestamp(), 'I love ham and hamburger!.', 1);
INSERT INTO user_profile VALUES ('Yujia Zhai', 'Yujia', 'Zhai', '1992-12-31', 'Brooklyn', 'Female', null, current_timestamp(), 'I love hamburger!.', 0);
INSERT INTO user_profile VALUES ('Harry Potter', 'Harry', 'Potter', '1991-01-01', 'Miami', 'Male', null, current_timestamp(), 'I love hamburger and magic!.', 2);

/*INSERT INTO relation VALUES ('chelseaisgood', 'Sirius_Black', 3, 3, '2016-04-01 01:00:00');*/
INSERT INTO relation VALUES ('Frank Lampard', 'chelseaisgood', 3, 2, '2016-04-01 03:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'John Terry', 0, 3, '2016-04-01 05:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Juan Mata', 3, 3, '2016-04-01 07:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Atlético Madrid', 3, 3, '2016-04-01 09:00:00');
/*INSERT INTO relation VALUES ('chelseaisgood', 'Titanic', 3, 3, '2016-04-01 11:00:00');*/
INSERT INTO relation VALUES ('Yujia Zhai', 'Titanic', 1, 3, '2016-04-01 11:00:00');

INSERT INTO relation VALUES ('chelseaisgood', 'Man from the Stars', 3, 3, '2016-04-01 13:00:00');
/*INSERT INTO relation VALUES ('chelseaisgood', 'Terminator', 3, 3, '2016-04-01 15:00:00');*/

INSERT INTO relation VALUES ('Yujia Zhai', 'Terminator', 0, 3, '2016-04-01 15:00:00');
INSERT INTO relation VALUES ('chelseaisgood', 'Yujia Zhai', 3, 3, '2016-04-01 17:00:00');

INSERT INTO relation_history VALUES ('Sirius_Black', 'chelseaisgood', '2016-04-01 00:28:00', 0);
/*INSERT INTO relation_history VALUES ('chelseaisgood', 'Sirius_Black', '2016-04-01 00:30:00', 1);*/


INSERT INTO location VALUES (1, 'Times Square', 'New York City', 'NY', '40.758899', '-73.9873197', 'chelseaisgood');  

INSERT INTO posting VALUES (1, 'chelseaisgood', '2016-04-01 10:28:00', 'Eating Well in NYC(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 3, 0 );
    
INSERT INTO posting VALUES (2, 'chelseaisgood', '2016-04-01 10:28:30', 'Eating Well in Shanghai(FOF)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 2, 0 );
    
INSERT INTO posting VALUES (3, 'chelseaisgood', '2016-04-01 10:28:50', 'Eating Well in Home(F)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 1, 0 );
    
INSERT INTO posting VALUES (4, 'Yujia Zhai', '2016-04-01 10:29:00', 'Eating Well in NYC(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 3, 0 );
    
INSERT INTO posting VALUES (5, 'Harry Potter', '2016-04-01 10:29:20', 'Eating Well in Hogwarts(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), null, 3, 0 );
    
INSERT INTO posting VALUES (6, 'Harry Potter', '2016-04-01 10:29:40', 'Eating Well in Hogwarts(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), null, 2, 0 );


INSERT INTO posting VALUES (7, 'Yujia Zhai', '2016-03-31 10:29:00', 'Eating Well in NYC(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), null, 0, 0 );
    
INSERT INTO posting VALUES (8, 'Yujia Zhai', '2016-03-01 10:29:00', 'Eating Well in NYC(all)', 
	'When I started researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), null, 3, 0 );
    
INSERT INTO posting VALUES (9, 'chelseaisgood', '2016-04-01 10:28:00', 'Eating Well in NYC(all)', 
	'When I began researching and reviewing healthy and sustainable restaurants across Manhattan in the summer of 2008, I visited and ate at over 125 in the first three months. It was an incredible culinary experience to sample such a diversity of food in such a short period of time.', 
	LOAD_FILE('g:/favourite.jpg'), LOAD_FILE('g:/hero-webloop.mp4'), 2, 0 );


INSERT INTO link values (1, 1);
INSERT INTO link values (2, 1);
INSERT INTO link values (3, 1);
INSERT INTO link values (4, 1);
INSERT INTO link values (5, 1);
INSERT INTO link values (6, 1);
INSERT INTO link values (7, 1);
INSERT INTO link values (8, 1);
INSERT INTO link values (9, 1);
  
    
/*INSERT INTO post_like VALUES ( 1, 'Sirius_Black', '2016-04-01 11:28:00'); */
INSERT INTO post_like VALUES ( 2, 'John Terry', '2016-04-01 11:28:01');  
INSERT INTO post_like VALUES ( 5, 'John Terry', '2016-04-01 11:28:03');
INSERT INTO post_like VALUES ( 6, 'John Terry', '2016-04-01 11:28:04');    
INSERT INTO post_like VALUES ( 8, 'John Terry', '2016-04-01 11:28:02');   
INSERT INTO post_like VALUES ( 9, 'John Terry', '2016-04-01 11:28:09'); 
INSERT INTO post_like VALUES ( 9, 'Juan Mata', '2016-04-01 11:28:09'); 

/*INSERT INTO location_post_like VALUES ( 1, 1, 'Sirius_Black', '2016-04-01 11:38:00');*/  
INSERT INTO location_post_like VALUES ( 1, 2, 'John Terry', '2016-04-01 11:38:00'); 
INSERT INTO location_post_like VALUES ( 1, 5, 'John Terry', '2016-04-01 11:38:01'); 
INSERT INTO location_post_like VALUES ( 1, 6, 'John Terry', '2016-04-01 11:38:02');   
INSERT INTO location_post_like VALUES ( 1, 7, 'John Terry', '2016-04-01 11:38:03');  
INSERT INTO location_post_like VALUES ( 1, 9, 'Juan Mata', '2016-04-01 11:38:04'); 
INSERT INTO location_post_like VALUES ( 1, 9, 'John Terry', '2016-04-01 11:38:04');

INSERT INTO post_comments VALUES ( 1, '2016-04-01 11:38:00', 'Sirius_Black', 'chelseaisgood', 'Nice food. Hope I can go there next time!'); 
INSERT INTO post_comments VALUES ( 4, '2016-04-01 11:38:00', 'chelseaisgood', 'Yujia Zhai', 'Nice food. Hope I can go there next time!');
INSERT INTO post_comments VALUES ( 4, '2016-04-01 11:38:00', 'Yujia Zhai', 'chelseaisgood', 'I can go with you!');
 
INSERT INTO bulletin_comments VALUES ( 'chelseaisgood', '2016-04-01 11:37:00', 'Sirius_Black', 'chelseaisgood', 'Happy Birthday!');  
INSERT INTO bulletin_comments VALUES ( 'chelseaisgood', '2016-04-01 11:38:00', 'chelseaisgood', 'Sirius_Black', 'Thank you!');   


INSERT INTO bulletin_comments VALUES ( 'John Terry', '2016-04-01 11:37:05', 'chelseaisgood', 'John Terry', 'Happy Birthday!');  
INSERT INTO bulletin_comments VALUES ( 'John Terry', '2016-04-01 11:38:36', 'John Terry', 'chelseaisgood', 'Thank you! You are the best.');   