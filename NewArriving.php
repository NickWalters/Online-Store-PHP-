<?php

$username="22243339";
$password="X23CZw2X";
$server="localhost";
$database="DB_22243339";


$conn=mysqli_connect($server, $username, $password, $database);

// Check connection
if(mysqli_connect_errno())
{
	echo "Failed to connect to MYSQL: " . mysqli_connect_error();
}

mysql_select_db("DB_22243339", $conn);
$pCode = $_POST["product code"];
$pName = $_POST["product name"];
$pPrice = $_POST["product price"];
$pQuantity = $_POST["quantity"];

$sql = "INSERT INTO Products (ProductID, ProductName, Price, Units)
VALUES ('$pCode', '$pName', '$pPrice', '$pQuantity')";

echo $sql
echo "<br>";
$result = $conn->query($sql);

if(!result)
{
	die('Error: ' . mysql_error());
}
else{
	echo "1 record added";
}
mysql_close($conn);
?>