/*
DROP SCHEMA IF EXISTS testdb;
CREATE DATABASE testDB;
*/
use db_22243339;


/*
--Table Structure for table 'Customers'
*/


CREATE TABLE IF NOT EXISTS Customers (
   PersonID INT(11) NOT NULL AUTO_INCREMENT,  -- Connects to table 'Orders' and OrderUserID
   Email VARCHAR(100),
   FirstName VARCHAR(100) NOT NULL,
   LastName VARCHAR(100),
   City VARCHAR(90),
   Zip INT(10),
   CustomerState VARCHAR(50),
   Address VARCHAR(200) NOT NULL,
   Country VARCHAR(20),
   Phone VARCHAR(50) NOT NULL,
   PRIMARY KEY (PersonID)
  );
  
  
INSERT INTO Customers (PersonID, Email, FirstName, LastName, City, Zip, CustomerState, Address, Country, Phone) VALUES
(1, '1@gmail.com', 'Fred', 'Innings','Brisbane', 6543, 'QLD', '20 Not telling avenue', 'Australia', '932363626'),
(2, '2@gmail.com', 'Mark', 'Smith', 'Perth', 3212, 'WA', '122 cralic road', 'Australia', '93223463221'),
(3, '3@gmail.com', 'Leo', 'Red', 'Melbourne', 2342, 'VIC', '90 normanly drive', 'Australia', '932645321'),
(4, '4@gmail.com', 'Nick', 'Hallows', 'Perth', 4294, 'WA', '44 happylane drive', 'Australia', '932222565621'),
(5, '5@gmail.com', 'Mary', 'Jane', 'Perth', 6383, 'WA', '3 iverno crescent', 'Australia', '93365543321'),
(6, '6@gmail.com', 'Julie', 'Bishop', 'Perth', 9563, 'WA', '100 richmane lane', 'Australia', '9323456421'),
(7, '7@gmail.com', 'Cynthia', 'Wang','Hobart', 3456, 'TAS', '12 trump avenue', 'Australia', '9322364641'),
(8, '8@gmail.com', 'Mike', 'Hunt', 'Albany', 7544, 'WA', '23 mapatazzie road', 'Australia', '9322236421'),
(9, '9@gmail.com', 'Brett', 'Howell', 'Adelaide', 8953, 'SA', '983 chindes lane', 'Australia', '9322234651'),
(10, '10@gmail.com', 'Paul', 'Grabic', 'Sydney', 7853, 'VIC', '78 yives road', 'Australia', '932223463621');
  
  
  
/*
--Table Structure for table 'Products'
*/

CREATE TABLE IF NOT EXISTS Products (
  ProductID int(11) NOT NULL AUTO_INCREMENT,  -- Connects to table 'orderdetails' and DetailProductID 
  ProductName varchar(100) COLLATE latin1_german2_ci NOT NULL,
  Price float NOT NULL,
  Units float DEFAULT NULL,
  UnitsOnOrder float default NULL,
  PRIMARY KEY (ProductID)
);

 
 INSERT INTO Products (ProductID, ProductName, Price, Units) VALUES
(1, 'Bitcoin', 5672, 134),
(2, 'Ethereum', 390, 390),
(3, 'Ripple', 0.31, 12343),
(4, 'Litecoin', 70, 432),
(5, 'Dash', 400, 34),
(6, 'IOTA', 0.72, 90000),
(7, 'Monero', 120, 200),
(8, 'OmiseGO', 12, 900),
(9, 'Zcash', 333, 100),
(10, 'TenX', 3, 333),
(11, 'NEO', 45, 1000),
(12, 'NEM', 0.27, 3009);

/*
--Table Structure for table 'Orders'
*/
 
 CREATE TABLE IF NOT EXISTS Orders (
  OrderID int(11) AUTO_INCREMENT, -- Connects to table 'Customer' and ID
  PersonID int(11) NOT NULL,  -- Connects to table 'Orders' and OrderUserID
  ProductID int(11) NOT NULL,
  Quantity int(11) NOT NULL,
  Price int(11) NOT NULL,
  OrderDate DATETIME,
  PRIMARY KEY (OrderID),
  FOREIGN KEY (PersonID) REFERENCES Customers(PersonID),
  FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

INSERT INTO Orders (OrderID, PersonID, ProductID, Quantity, Price, OrderDate) VALUES
(1, 4, 6, 510, 0.72, '2017-10-29 08:33:23'),
(2, 1, 1, 2, 5672, '2017-10-27 02:10:12'),
(3, 4, 2, 1, 390, '2017-05-12 08:33:23'),
(4, 10, 5, 4, 400, '2017-01-23 09:53:41'),
(5, 7, 11, 67, 45, '2017-02-18 08:33:23'),
(6, 6, 3, 1000, 0.31, '2017-04-29 08:33:23'),
(7, 2, 4, 39, 70, '2017-10-08 08:33:23'),
(8, 3, 7, 45, 120, '2017-06-08 08:33:23'),
(9, 5, 8, 100, 12, '2017-07-08 04:34:48'),
(10, 8, 9, 10, 333, '2017-10-03 02:32:23'),
(11, 7, 1, 30, 5672, '2017-04-02 01:56:23'),
(12, 7, 2, 67, 390, '2017-09-01 9:10:13');


/*
QUERY 1
*/
SELECT customers.*
FROM customers
NATURAL JOIN Orders
GROUP BY PersonID
HAVING COUNT(PersonID) >= 3;


/*
QUERY 2
*/ 
select customers.*
from customers
natural join orders
natural join products
group by personid
having sum(Orders.price * quantity) >= 500;

/*
QUERY 3
*/ 
select products.*
from products
LEFT OUTER JOIN orders
ON Products.ProductID = Orders.ProductID
WHERE OrderID IS NULL;

/*
QUERY 4
*/ 
select products.*
from products
NATURAL JOIN orders
GROUP BY ProductID
HAVING COUNT(PersonID) = 1;


/*
QUERY 5
*/ 
SELECT Products.*, COUNT(OrderID) AS NumOfOrders
FROM products
LEFT OUTER JOIN orders
ON Orders.ProductID = Products.ProductID
GROUP BY ProductID;


/*
QUERY 6
*/ 
SELECT SUM(Quantity)
FROM Orders;

/*
QUERY 7
*/ 
DELIMITER //
CREATE FUNCTION CostOfBestBuyers(n INT)
RETURNS int(11)
NOT DETERMINISTIC
	BEGIN
		SELECT SUM(A.TotalPrice)
	FROM (
		select SUM(Orders.price * quantity) AS TotalPrice
		from customers
		natural join orders
		natural join products
		GROUP BY PersonID
		ORDER BY TotalPrice DESC LIMIT n) AS A;
	END; // 
DELIMITER ;



CALL CostOfBestBuyers(5);


/*
QUERY 8
*/ 
CREATE VIEW BuyerCostPerProduct AS
SELECT Customers.PersonID, Customers.FirstName, Products.ProductID, Products.ProductName, Orders.OrderDate, Orders.Price AS PricePaidOnPurchase
FROM Customers NATURAL JOIN orders
NATURAL JOIN products;

select * from BuyerCostPerProduct;

