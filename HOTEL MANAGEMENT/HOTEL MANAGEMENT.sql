
CREATE DATABASE HOTEL1
USE HOTEL1

CREATE TABLE ROOM_TYPES (
type_id int primary key identity,
type_name varchar(50)not null ,
type_description varchar  (50) ,
price float )


CREATE TABLE ROOMS (
rooms_id int primary key identity,
types_id int,
isBooked bit ,
floorNumber int  ,
foreign key (rooms_id) references Room_Types (type_id) )


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
	email varchar (50),
	phone varchar (50),
	adress varchar (50) )

create table Reservations (
	reservations_id int primary key identity not null,
    customer_id INT,
    rooms_id INT,InDate date unique ,
	OutDate date unique,
	TotalCost   float,
    foreign key (reservations_id) references Customers (Customer_id) ,
	foreign key (reservations_id) references Rooms (rooms_id) 

	 )

create table Payments(
payment_id int primary key identity,
reservations_id int,
	amount int  ,
	PaymentDate date ,
	PaymentMethod varchar (50),
	foreign key (payment_id) references Reservations (Reservations_id)
	)

CREATE TABLE Spendings (
    spending_id INT PRIMARY KEY IDENTITY ,
    reservation_id INT,
    description VARCHAR(255),
    amount FLOAT ,
    FOREIGN KEY (reservation_id) REFERENCES Reservations(reservations_id))


CREATE VIEW AllCustomerReservations
AS
select Customers.name  AS [Customers] ,
 reservations.InDate AS [CheckIn],
 reservations.OutDate AS [CheckOut]
 from customers
 join reservations On
 customers.Customer_id= reservations.reservations_id


 CREATE PROCEDURE GetRoomDetails
    @roomID INT
AS
BEGIN
    SELECT Rooms.rooms_id, ROOM_TYPES.type_name , ROOM_TYPES.price
    FROM Rooms
    JOIN ROOM_TYPES ON Rooms.types_id = Room_Types.type_id
    WHERE Rooms.rooms_id = @roomID;
END;



create function CalculateTotalAmount (@Customer_Id int)
returns float
As
begin
declare @Amount float;
select @Amount=Payments.Amount from Payments inner join Reservations on Reservations.reservations_id=Payments.reservations_id where @Customer_Id=Reservations.customer_id
return @Amount
end