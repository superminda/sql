<!DOCTYPE html>
<html>
    <head>
        <style>
            /*
            table {
                width: 100%;
                border-collapse: collapse;
            }

            table, td, th {
                border: 1px solid black;
                padding: 5px;
            }

            th {text-align: left;}
            */
        </style>
        
    </head>
    <body>
       
		
        <?php
			
            $q = $_REQUEST["q"];
            //$q =test_input($q);

            $servername = "localhost";
            $username = "root";
            $password = "";
			$my_db = 'myhw3';
            // Create connection
            $conn = mysqli_connect($servername, $username, $password, $my_db);
             // Check connection
            if (!$conn) {
                die("Connection failed: " . mysqli_connect_error());
            } 
			
            mysqli_select_db($conn,'myhw3');
			//@mysqli_select_db('myhw3',$conn);
			$sql = "call myhw3.ifexists_user('".$q."');";
			
            $result = mysqli_query($conn,$sql);
			$array = $result->fetch_array(MYSQLI_ASSOC);
			//var_dump($array['define']) ;
			if($array['define']) {	
				echo "*User Name already existed";
				echo '<script language="javascript">alert(1);</script>';
				echo "<script> indexShowTooltip('reg_user','帐号已存在'); </script> ";
				}else {
					echo "OK";
				}
			//echo $define;
			
			
            


            function test_input($data) {
              $data = trim($data);
              $data = stripslashes($data);
              $data = htmlspecialchars($data);
              return $data;
            }

            mysqli_close($conn);
        ?>
    
    </body>
</html>