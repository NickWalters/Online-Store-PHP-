<?php
if(!isset($_POST['sendIt']))
{
?>

<html>
<head>
	 <title>BuyingTransaction</title>
</head>
<body>
<H1>Welcome to the Online Shop</H1>
<form action= "BuyingTransaction.php" method="post">
<label>Choose a Product: <label>
	<select name="Product">
		<?php
			$username="22243339";
			$password="X23CZw2X";
			$server="localhost";
			$database="DB_22243339";
			
			$conn = mysqli_connect($server, $username, $password, $database);
			mysqli_select_db($conn, "DB_22243339");
			$selectNames = mysqli_query($conn, "SELECT ProductName FROM Products");
			while($sqlRow = mysqli_fetch_array($selectNames, MYSQL_ASSOC)) {
				echo "<option>" . $sqlRow['ProductName'] . "</option>";
			}
		?>
	</select>
<p>Quantity: <input type="number" name="quantity"/></p>
<p>Name:<input type="text" name="user" /></p>
<p>Phone number:<input type="text" name="phone" /></p>
<p>Address:<input type="text" name="address" /></p>
<p><input type="submit" name="sendIt"/></p>
</form>
</body>
</html>
<?php
}
else if(empty($_POST['quantity']) || empty($_POST['user']) || empty($_POST['phone']) || empty($_POST['address']))
{
?>
<html>
<head>
	 <title>BuyingTransaction</title>
</head>
<body>
<H1>Welcome to the Online Shop</H1>
<form action= "BuyingTransaction.php" method="post">
<label>Choose a Product: <label>
	<select name="Product" size="1">
		<?php
			$username="22243339";
			$password="X23CZw2X";
			$server="localhost";
			$database="DB_22243339";
			
			$conn = mysqli_connect($server, $username, $password, $database);
			mysqli_select_db($conn, "DB_22243339");
			$selectNames = mysqli_query($conn, "SELECT ProductName FROM Products");
			while($sqlRow = mysqli_fetch_array($selectNames, MYSQL_ASSOC)) {
				echo "<option>" . $sqlRow['ProductName'] . "</option>";
			}
		?>
	</select> <br>
<p>Quantity: <input type="number" name="quantity"/></p>
<p>Name:<input type="text" name="user" /></p>
<p>Phone number:<input type="text" name="phone" /></p>
<p>Address:<input type="text" name="address" /></p>
<p><input type="submit" name="sendIt"/></p>
</form>
</body>
</html>
<?php
}
else
{
?>
<html>
<head>
<title> Apache MYSQL </title>
</head>
<body bgcolor="BBE0E3">
<h1>From Web Server to Database Server</h1>
</body>
</html>
<?php
$username="22243339";
$password="X23CZw2X";
$server="localhost";
$database="DB_22243339";

$selectedProduct = $_POST["Product"];
$selectedQuantity = $_POST["quantity"];
$userName = $_POST["user"];
$phone = $_POST["phone"];
$address = $_POST["address"];

	
//Open the connection
$conn = mysqli_connect($server, $username, $password, $database);

if (!$conn) {
  die("Connection failed: " . mysqli_connect_error());
  die("could not connect: " . mysql_error());
  echo "\"" . $database . "\" <font color=#FF0000>Connection Failed</font>";
} 
	echo "\"" . $database . "\" <font color=#1AEE44>Connected Successfully</font>";

//Choose the database
$chosenDB=mysqli_select_db($conn,'DB_22243339');

// Get the maximum number of items in stock for the selected product
$maxValTable= "SELECT Units FROM Products WHERE Products.ProductName = '".$selectedProduct."'";
$sqlResult = mysqli_query($conn, $maxValTable);
while($sqlRow=mysqli_fetch_array($sqlResult, MYSQLI_ASSOC))
{
	$row=$sqlRow['Units'];
}
$maxStock = $row;

if($selectedQuantity > $maxStock) {
		$message = 'You tried to buy a greater amount than what was in Stock: ' . mysql_error() . "\n";
		die($message);
	}

	
$priceTable = "SELECT Price FROM Products WHERE Products.ProductName = '".$selectedProduct."'";
$sqlRes = mysqli_query($conn, $priceTable);
while($sqlRow=mysqli_fetch_array($sqlRes, MYSQLI_ASSOC))
{
	$priceRow = $sqlRow['Price'];
}
$price = $priceRow;
$totalPrice = $price * $selectedQuantity;

$sqlInsert = "INSERT INTO Customers (FirstName, Address, Phone)
VALUES ($userName, $address, $phone)";

if(mysqli_query($conn, $sqlInsert)) {
		echo "new member registered successfully!";
	} else {
		echo "Error: " . $sqlInsert . "<br>" . $mysqli_error($conn);
	}

	
	
	
mysqli_close($conn);


}

?>