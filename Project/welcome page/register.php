<?php

   
    $signup_name = $_POST['user_name']; 
    $signup_email = $_POST['email']; 
	$signup_password = $_POST['password']; 
	$signup_repassword = $_POST['repassword']; 

 //    $signup_name = 'test3_bb998b'; 
 //    $signup_email = 'test@nyu.edu'; 
	// $signup_password = 'aabbccdd'; 
	// $signup_repassword = 'aabbccdd'; 



	if (strlen($signup_name) < 6 || strlen($signup_name) > 16){ 
		echo 'invalid_username_length'; return;
	} else if((preg_match("/^[A-Za-z_0-9]+$/",$signup_name)) == false){
	 	echo 'invalid_username_character';  return;
	 } else {
		$signup_email = test_input($signup_email);
		if (!preg_match("/([\w\-]+\@[\w\-]+\.[\w\-]+)/", $signup_email)) {
		   echo "invalid_email_format";  return;
		}
		if($signup_password!= $signup_repassword){
			echo "repwd_not_equal"; return;
		} else {
			if (strlen($signup_password) < 8 || strlen($signup_password) > 16){ 
				echo 'invalid_pwd_length'; return;
			} else if((preg_match("/^[A-Za-z_0-9]+$/",$signup_password)) == false){
			 	echo 'invalid_pwd_character';  return;
			 }
		}
	}


	/*
    $myFile = "testFile.txt";
    $fh = fopen($myFile, 'w') or die("can't open file");
    fwrite($fh, $username);
	fwrite($fh, $password);
    fclose($fh);
	*/
	$servername = "localhost";
	$username = "root";
	$password = "";
	$my_db = 'project';
	// Create connection
	$conn = mysqli_connect($servername, $username, $password, $my_db);
	 // Check connection
	if (!$conn) {
		die("Connection failed: " . mysqli_connect_error());
	} 
	
	mysqli_select_db($conn,'project');
	//@mysqli_select_db('project',$conn);
	$sql = "call project.signup('".$signup_name."', '".$signup_email."', '".$signup_password."');";
	
	$result = mysqli_query($conn,$sql);
	$array = $result->fetch_array(MYSQLI_ASSOC);
	if($array['signup_result']) {
		echo 'signup_successful';
		
	}else {
		echo 'user_existed';
	}
	mysqli_close($conn);




// Function for test the email-format
	function test_input($data) {
	   $data = trim($data);
	   $data = stripslashes($data);
	   $data = htmlspecialchars($data);
	   return $data;
	}

?>