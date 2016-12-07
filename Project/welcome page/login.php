<?php
    $login_name = $_POST['username']; 
	$login_password = $_POST['password']; 
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
	$sql = "call project.ifexists_user('".$login_name."');";
	
	$result = mysqli_query($conn,$sql);
	$array = $result->fetch_array(MYSQLI_ASSOC);
	if($array['define']) {
		
		$result->close();
		$conn->next_result();
		
		$sql_login = "call project.login('".$login_name."', '".$login_password."');";
		$result_login = mysqli_query($conn,$sql_login);
		$array_login = $result_login->fetch_array(MYSQLI_ASSOC);
		if($array_login['login_result']) {
			echo 'custom_login';
		}else { echo 'password_error'; }
	}else {
		echo 'user_noexist';
	}
	mysqli_close($conn);
?>
