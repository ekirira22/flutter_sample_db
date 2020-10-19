<?php
  //define server host name
  define("HostName","localhost");

  //Define mySQL database name
  define("DatabaseName", "sample_flutter_db");
  //Define database username and password
  define("HostUser", "root");
  define("HostPass", "");
  //create a mySQL connection
  $con = mysqli_connect(HostName,HostUser,HostPass,DatabaseName);
  //check if the connection exists
  if(!$con){
    die("Connection Failed: ".mysqli_connect_error());
  }
  //get details from JSON file and store them in variables
  $name = mysqli_real_escape_string($con, $_POST['name']);
  $email = mysqli_real_escape_string($con, $_POST['email']);
  $phone_number = mysqli_real_escape_string($con, $_POST['phone_number']);


  //we have now received data from JSON object from app and now ready to store it into the database
// Creating SQL query and insert the record into MySQL database table.

  $Sql_Query = "INSERT INTO user_info (name,email,phone_number) VALUES ('$name','$email','$phone_number')";

  $results = mysqli_query($con, $Sql_Query);
  if($results>0){
    echo "User added successfully";
  }

  mysqli_close($con);
 ?>
