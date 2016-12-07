<html>
	<body>
	<?php

	 //session_id(111);

	 //改cookie保存的session id生命周期为1分钟

	 //这样cookie保存的PHPSESSID不会浏览器一退出就被删除

	 //session_set_cookie_params(60*1);

	 session_start();

	 //print_r($_SESSION);
	 if(isset($_SESSION['name'])){
		$username = $_SESSION['name'];
		echo $username; 
	 }else {
		 echo "<script language='javascript'>document.location = 'index.html '</script>;";
	 }
	 
	 
	// print_r($_COOKIE);

	?>
	</body>
</html>