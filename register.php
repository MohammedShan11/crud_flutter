<?php
include 'connection.php';
$name=$_POST['username'];
$email=$_POST['email'];
$phone=$_POST['phone'];
$password=$_POST['password'];

$data1=mysqli_query($conn,"INSERT into login(email,password) values('$email','$password')");
$log_id=mysqli_insert_id($conn);
$data2=mysqli_query($conn,"INSERT into register(username,number,login_id) values('$name','$phone','$log_id')");

if($data1 && $data2){
    $myarray['result']="success";
    $myarray['response']="done";
}else{
    $myarray['result']="failed";
}
echo json_encode($myarray);
?>