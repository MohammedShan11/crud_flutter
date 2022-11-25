<?php
include 'connection.php';
$email=$_POST['email'];
  $password=$_POST['password'];
  $data=mysqli_query($conn,"SELECT * from login where email='$email' && password='$password'");
  if($data->num_rows>0){
    while($row=mysqli_fetch_assoc($data)){
    $myarray['message']='user successfully logged in';
    $myarray['login_id']=$row['log_id'];
  }
}
else{
    $myarray['message']='failed to login';
}
echo json_encode($myarray);
?>