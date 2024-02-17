create database sqlpractical;

create table Customers(
CustomerID int Primary key identity,
Firstname varchar(255) not null,
Lastname varchar(255) not null,
Email varchar(255) not null,
PhoneNo bigint not null
);

create table Orders(
OrderID int Primary key identity,
OrderDate date not null,
TotalAmount int not null,
CustomerID int not null,
Foreign key (CustomerID) REFERENCES Customers(CustomerID)
);


create table OrderDetails(
OrderDetailID int Primary key identity,
Quantity int not null,
UnitPrice int not null,
OrderID int not null,
Foreign key (OrderID) References Orders(OrderID),
ProductID int not null,
Foreign key (ProductID) References Products(ProductID)
);

Create table Products(
ProductID int Primary key identity,
ProductName varchar(255) not null,
UnitPrice int not null,
Instockquantity int not null
);

INSERT INTO Customers (Firstname, Lastname, Email, PhoneNo)
VALUES
('John', 'Doe', 'john.doe@example.com', 1234567890),
('Jane', 'Smith', 'jane.smith@example.com', 9876543210),
('Alice', 'Johnson', 'alice.johnson@example.com', 4567891230),
('Bob', 'Brown', 'bob.brown@example.com', 7891234560),
('Mary', 'Davis', 'mary.davis@example.com', 3216549870),
('Tom', 'Wilson', 'tom.wilson@example.com', 6549873210),
('Sarah', 'Moore', 'sarah.moore@example.com', 9517534680),
('Chris', 'Lee', 'chris.lee@example.com', 7539514680),
('Emily', 'Clark', 'emily.clark@example.com', 1593574860),
('David', 'Allen', 'david.allen@example.com', 3571594860);

INSERT INTO Orders (OrderDate, TotalAmount, CustomerID)
VALUES
('2024-02-01', 100, 1),
('2024-02-02', 150, 2),
('2024-02-03', 200, 3),
('2024-02-04', 120, 4),
('2024-02-05', 180, 5),
('2024-02-06', 220, 6),
('2024-02-07', 130, 7),
('2024-02-08', 190, 8),
('2024-02-09', 210, 9),
('2024-02-10', 140, 10);

INSERT INTO OrderDetails (Quantity, UnitPrice, OrderID, ProductID)
VALUES
(2, 500, 1, 1),
(1, 1000, 2, 2),
(3, 100, 3, 3),
(2, 800, 4, 4),
(1, 1200, 5, 5),
(2, 400, 6, 6),
(1, 300, 7, 7),
(2, 200, 8, 8),
(3, 50, 9, 9),
(1, 20, 10, 10);


INSERT INTO Products (ProductName, UnitPrice, Instockquantity)
VALUES
('Smartphone', 500, 50),
('Laptop', 1000, 30),
('Headphones', 100, 100),
('Camera', 800, 20),
('TV', 1200, 25),
('Tablet', 400, 40),
('Printer', 300, 60),
('Monitor', 200, 80),
('Keyboard', 50, 150),
('Mouse', 20, 200);

--QUERY NO 1

create login Waseem with password = '123'
create user Order_Clerk for login Waseem

grant insert on Orders to Order_Clerk
grant update on OrderDetails to Order_Clerk


--QUERY NO 2

create trigger Update_Stock_Audit on Products
after update
as
begin
select * from deleted
select * from inserted
end

update Products set Instockquantity = 60 where ProductID = 1


--QUERY NO 3

SELECT Firstname, Lastname, OrderDate, TotalAmount from Customers as c JOIN Orders as o ON c.CustomerID = o.CustomerID;

--QUERY NO 4

SELECT ProductName, Quantity, sum(TotalAmount) as TotalPrice from Products as p JOIN OrderDetails as od ON p.ProductID = od.ProductID JOIN Orders as o ON od.OrderID = o.OrderID GROUP BY ProductName ,Quantity

--QUERY NO 5

create procedure GetOrdersByCustomer
as 
begin

end

--QUERY NO 6

create view OrderSummary
as
SELECT OrderID, OrderDate, CustomerID, TotalAmount from Orders;

select* from OrderSummary

--QUERY NO 7

create view ProductInventory
as
SELECT ProductName, Instockquantity from Products

select * from ProductInventory


--QUERY NO 8

Select Firstname, Lastname,OrderID , OrderDate, TotalAmount  from Customers as c JOIN OrderSummary as v ON c.CustomerID = v.CustomerID 


