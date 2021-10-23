DROP TABLE primaryuser CASCADE CONSTRAINTS;
DROP TABLE administrator CASCADE CONSTRAINTS;
DROP TABLE user_address CASCADE CONSTRAINTS;
DROP TABLE user_payment CASCADE CONSTRAINTS;
DROP TABLE Product CASCADE CONSTRAINTS;
DROP TABLE ProductCategory CASCADE CONSTRAINTS;
DROP TABLE ProductInventory CASCADE CONSTRAINTS;
DROP TABLE Cart CASCADE CONSTRAINTS;
DROP TABLE Orders CASCADE CONSTRAINTS;
DROP TABLE Shipping CASCADE CONSTRAINTS;


--users
CREATE TABLE primaryuser(
user_id INTEGER PRIMARY KEY,
username VARCHAR(25)  NOT NULL,
first_name VARCHAR(25)  NOT NULL,
last_name VARCHAR(25)  NOT NULL,
email VARCHAR(45)  NOT NULL,
password VARCHAR(25) NOT NULL,
transactions INTEGER  DEFAULT 0,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE administrator(
	employee_id INTEGER PRIMARY KEY,
user_id INTEGER REFERENCES primaryuser(user_id) ,
	yearly_salary INTEGER,
admin_role VARCHAR(25) NOT NULL
);


CREATE TABLE user_address(
address_id INTEGER PRIMARY KEY,
user_id INTEGER REFERENCES primaryuser(user_id) ,
country VARCHAR(25),
province VARCHAR(25),
city VARCHAR(25),
telephone INTEGER,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE user_payment(
payment_id INTEGER PRIMARY KEY,
user_id REFERENCES primaryuser(user_id),
payment_type VARCHAR(25) NOT NULL,
provider VARCHAR(25) NOT NULL,
account_no INTEGER NOT NULL,
expiry VARCHAR(25) NOT NULL
);



INSERT INTO primaryuser (user_id, username, first_name, last_name, email, password) VALUES (1, 'thom', 'Thomas', 'Shelby', 'ThomasShelby@Peaky.uk', 'powder1');
INSERT INTO primaryuser (user_id, username, first_name, last_name, email, password) VALUES (2, 'paul', 'Pauly', 'Grey', 'PaulyGrey@Peaky.uk', 'powder2');
INSERT INTO primaryuser (user_id, username, first_name, last_name, email, password) VALUES (3, 'cynth', 'Cynthia', 'Show', 'CynthiaShow@Peaky.uk', 'powder3');
INSERT INTO primaryuser (user_id, username, first_name, last_name, email, password) VALUES (4, 'jasm', 'Jasmine', 'Hult', 'JasmineHult@Peaky.uk', 'powder4');
INSERT INTO primaryuser (user_id, username, first_name, last_name, email, password) VALUES (5, 'ash', 'Ash', 'Ketchup', 'AshKetchup@Peaky.uk', 'powder5');

INSERT INTO administrator (employee_id, user_id,yearly_salary, admin_role) VALUES (1, 1, 10000, 'admin');
INSERT INTO administrator (employee_id, user_id,yearly_salary, admin_role) VALUES (2, 2, 10000, 'admin2');
INSERT INTO administrator (employee_id, user_id,yearly_salary, admin_role) VALUES (3, 3, 10000, 'admin3');
INSERT INTO administrator (employee_id, user_id,yearly_salary, admin_role) VALUES (4, 4, 10000, 'admin4');
INSERT INTO administrator (employee_id, user_id,yearly_salary, admin_role) VALUES (5, 5, 100000, 'inventory manager');

INSERT INTO user_address (address_id, user_id, country, province, city, telephone) VALUES (1, 1, 'Canada', 'Ontario', 'Toronto', 4161112020);
INSERT INTO user_address (address_id, user_id, country, province, city, telephone) VALUES (2, 2, 'Canada', 'Ontario', 'Ottawa', 4161112342);
INSERT INTO user_address (address_id, user_id, country, province, city, telephone) VALUES (3, 3, 'Canada', 'Ontario', 'Hamilton', 4161118923);
INSERT INTO user_address (address_id, user_id, country, province, city, telephone) VALUES (4, 4, 'Canada', 'Ontario', 'Brampton', 4161117843);
INSERT INTO user_address (address_id, user_id, country, province, city, telephone) VALUES (5, 5, 'Canada', 'Ontario', 'Barrie', 4161115409);

INSERT INTO user_payment (payment_id, user_id, payment_type, provider, account_no, expiry) VALUES (1, 1, 'credit', 'MoneyHesit', 11100023402, '04/2023');
INSERT INTO user_payment (payment_id, user_id, payment_type, provider, account_no, expiry) VALUES (2, 2, 'credit', 'WinSin', 11100023402, '02/2024');
INSERT INTO user_payment (payment_id, user_id, payment_type, provider, account_no, expiry) VALUES (3, 3, 'debit', 'UnRoyalBank', 11100023402, '01/2025');
INSERT INTO user_payment (payment_id, user_id, payment_type, provider, account_no, expiry) VALUES (4, 4, 'credit', 'RoyalBank', 11100023402, '01/2024');
INSERT INTO user_payment (payment_id, user_id, payment_type, provider, account_no, expiry) VALUES (5, 5, 'giftcard', 'GoogleSuite', 11100023402, '08/2025');




--products and cart
CREATE TABLE ProductCategory (
  Category_ID INTEGER PRIMARY KEY,
  Category_Name VARCHAR2(30),
  Department VARCHAR2(30)
);

CREATE TABLE Product (
  Product_ID INTEGER PRIMARY KEY,
  Category_ID INTEGER REFERENCES ProductCategory(Category_ID),
  Product_Name VARCHAR2(30),
  Price INTEGER CHECK (Price > 0)
  );


CREATE TABLE ProductInventory (
  Inventory_ID INTEGER PRIMARY KEY,
  Product_ID INTEGER REFERENCES Product(Product_ID),
  Inventory_Name VARCHAR2(30),
  Amount INTEGER
);


CREATE TABLE Cart (
  Cart_ID INTEGER PRIMARY KEY,
  Total_Products VARCHAR2(30),
  Total_Price INTEGER, /*add shipping cost to total price (not included in dbms)*/
  Product_ID INTEGER REFERENCES Product(Product_ID)
);


SELECT * FROM ProductCategory ;
INSERT INTO ProductCategory  VALUES(1,'smart speaker','A');
INSERT INTO ProductCategory  VALUES(2,'smart theremometer','B');
INSERT INTO ProductCategory  VALUES(3,'smart light','C');

SELECT * FROM Product;
INSERT INTO Product VALUES(1,1,'google home',35);
INSERT INTO Product VALUES(2,2,'google thermometer',120);
INSERT INTO Product VALUES(3,3,'hue light',50);
INSERT INTO Product VALUES(4,1,'alexa',25);

SELECT * FROM ProductInventory;
INSERT INTO ProductInventory VALUES(1,1,'google home quantity',100);
INSERT INTO ProductInventory VALUES(2,2,'google thermometer quantity',70);
INSERT INTO ProductInventory VALUES(3,3,'hue light quanitity',250);
INSERT INTO ProductInventory VALUES(4,4,'alexa quantity',120);

SELECT * FROM Cart;
INSERT INTO Cart VALUES(1,7,70,4);
INSERT INTO Cart VALUES(2,5,80,3);
INSERT INTO Cart VALUES(3,4,90,2);
INSERT INTO Cart VALUES(4,2,100,1);


---- orders and shipping

CREATE TABLE Orders (
  Order_ID INTEGER PRIMARY KEY,
  Product_ID INTEGER REFERENCES Product(Product_ID),
 user_id INTEGER REFERENCES primaryuser(user_id),
  Customer_Name VARCHAR2(50),
  Street_Address VARCHAR2(50),
  City VARCHAR2(50),
  Province_State VARCHAR2(50),
  Postal_Code VARCHAR2(26),
  Order_Date VARCHAR(50)
);



SELECT * FROM orders;
INSERT INTO orders VALUES
(1682, 1, 2, 'William Graham', '142 Main Street', 'Montreal',
'Quebec', 'H0H9T5', '05/09/2021');

SELECT * FROM orders;
INSERT INTO orders VALUES 
(2964, 2, 3, 'Ben Parker', '328 Stark St', 'Montreal', 'Quebec',
'H9H4M7', '10/23/2021');

SELECT * FROM orders;
INSERT INTO orders VALUES 
(1992, 3, 4, 'James Wilson', '83 Molson Blvd', 'Ottawa', 'Ontario',
'K1Y6G8', '05/18/2021');



CREATE TABLE shipping (
    Shipping_ID INTEGER PRIMARY KEY,
    Product_ID INTEGER REFERENCES product(Product_ID),
    Order_ID INTEGER REFERENCES orders(Order_ID),
    Shipment_Date VARCHAR(50),
    Packing_Time VARCHAR(50)
);


SELECT * FROM shipping;
INSERT INTO shipping (Shipping_ID, Product_ID, Order_ID, Shipment_Date,
Packing_Time) VALUES (1, 1, 1682, '12/26/2021', '12/25/2021');


SELECT * FROM shipping;
INSERT INTO shipping (Shipping_ID, Product_ID, Order_ID, Shipment_Date,
Packing_Time) VALUES (468, 2, 2964, '10/23/2021', '10/21/2021');

SELECT * FROM shipping;
INSERT INTO shipping (Shipping_ID, Product_ID, Order_ID, Shipment_Date,
Packing_Time) VALUES (1635, 3, 1992, '09/18/2021', '09/15/2021');




SELECT Product_Name, Price
FROM Product;
     
SELECT Inventory_Name, Amount          
FROM ProductInventory
ORDER BY Amount ASC;   

SELECT Category_Name, Department
FROM ProductCategory
WHERE Category_Name = 'smart speaker';


SELECT DISTINCT Total_Products AS Small_Orders, Total_Price    
FROM Cart
WHERE Total_Products <= 5;

SELECT DISTINCT FIRST_NAME, LAST_NAME FROM PRIMARYUSER ORDER BY FIRST_NAME DESC;

SELECT DISTINCT EMPLOYEE_ID, ADMIN_ROLE FROM ADMINISTRATOR ORDER BY EMPLOYEE_ID DESC;

SELECT DISTINCT COUNTRY, CITY FROM USER_ADDRESS ORDER BY CITY DESC;

SELECT DISTINCT PAYMENT_TYPE FROM USER_PAYMENT ORDER BY PAYMENT_TYPE DESC;

SELECT * FROM shipping ORDER BY shipping_ID, shipment_Date;

SELECT * FROM Orders ORDER BY Street_Address ASC, Order_ID;
