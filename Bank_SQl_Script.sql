--Documentation For DB Banking System SQL Code Implementation
--MS-SQL PROJECT on Banking System name union_Bank

--PHASE I of project begins

--1)Q1.Create a database for a banking application called �Union_Bank� 
-----Using Our Database �Union_Bank'

create database Union_Bank
go

USE Union_Bank
go

--2)Q2.Create all the tables mentioned in the database diagram.
--create tables & add constraint Section 
--3)Q3. Create all the constraints based on the database diagram.

--Creating table named Customers
create table Customers 
(
CustomerId int primary key identity(1,1),
FirstName varchar(50) not null,
LastName varchar(50) not null,
Gender varchar(1) not null,
Email varchar(50) not null,
BirthDate date not null,
Age as year(getdate())-year (BirthDate),
City varchar(50) not null,
State varchar(50) not null,
--constraint ch1 check(Gender in ('m','f'))
);
go

--Creating table named Customer_phones
create table Customer_phones 
(
CustomerId int,
phone varchar(50) not null,
constraint  Customer_phones_IDS primary key (CustomerId, phone),
constraint Customer_phones_Customers foreign key (CustomerId) 
references Customers (CustomerId)
);
go

--Creating table named Branch
create table Branch 
(
BranchId int primary key,
BranchName varchar(50) not null,
Branch_Location varchar(50) not null,
);
go

--Creating table named Account
create table Account 
(
AccountNumber int primary key, 
AccountType varchar(50) ,
Balance float not null,
OpenDate date default getdate(),
Account_Status varchar(30) not null,
Branchid INT,
CustomerId int,
constraint customer_Account foreign key (CustomerId)
references Customers (CustomerId) ,
constraint Branch_Account foreign key (Branchid)
references Branch (BranchId) ,
--constraint ch2 check(Account_status in ('active','not active')),
);
go
  
---we can check on account type through this constraint to check if 
--- the account saving or current ---
alter table account add constraint check_status check(accounttype in ('saving','current'))

--Creating table named Transactions
create table Transactions 
(
Transaction_Type_Id int primary key identity (1,1),
TransactionType varchar(30) not null,
);
go

--Creating table named Card */
create table Card (
CardNumber int primary key,
CardType varchar(30) not null,
card_Status varchar (30) not null,
ExpiryDate date not null,
AccountNumber int,
constraint Card_Account  foreign key (AccountNumber)
references Account (AccountNumber) 
);
go

--Creating table named Employee
create table Employee (
EmployeeId int primary key,
FirstName varchar(30) NOT NULL,
LastName varchar(30) NOT null,
Salary DECIMAL NOT NULL,
Position varchar(50) NOT NULL,
SupervisorID int ,
branchid INT,
Dno INT ,
constraint super_Employee foreign key(SupervisorID)
REFERENCES Employee (EmployeeId) ,
CONSTRAINT branchid_Employee foreign key(branchid)
references branch(branchid) ,
);
go

--create table named Department
CREATE TABLE Department 
(
Dnumber INT PRIMARY KEY ,
Dname VARCHAR(50) NOT NULL,
MgriD INT ,
constraint manager_Employee foreign key(MgriD)
REFERENCES Employee (EmployeeId) 
)

ALTER TABLE employee 
ADD constraint Dno_Employee foreign key(Dno)references Department (DNumber) 

--Creating table named Loan
create table Loan (
LoanId int primary key,
Amount decimal not null,
loan_months_terms int not null,
LoanType varchar(30) not null,
StartDate date not null,
EndDate date not null,
InterestRate varchar(20) not null,
customerid int,
BranchId int,
constraint Loan_customer foreign key (customerid)
references Customers (customerid),
constraint Loan_Branch foreign key (BranchId)
references Branch (BranchId)
);
go


--Creating table named ATM
create table ATM (
AtmId int primary key,
Atm_location varchar(50) NOT NULL,
Atm_status varchar(30) NOT NULL ,
BranchId int,
constraint ATM_Branch foreign key (BranchId)
references Branch(BranchId)
);
GO

--create table Account_Atm_transcation
CREATE TABLE Account_Atm_transcation
(
TransactionDate  DATE DEFAULT GETDATE() ,
AccountNumber INT,
transactionid INT identity(1,1) primary key,
Transaction_Type_Id int,
Atmid INT ,
Amount FLOAT NOT NULL, 
CONSTRAINT Atm_account_transcation foreign key (AccountNumber) references Account(AccountNumber),
CONSTRAINT transcation_Account_Atm foreign key (Transaction_Type_Id) references Transactions(Transaction_Type_Id)
);
go
--------------------------------------------------------------------------------------
----4)Q4. Insert at least 10 rows in each table.

--insert data to Customers tables
insert into Customers
values
('Emmanuel','Akpobari','m','EmmanuelAkpobari@gmail.com','1982/8/2','GREENWOOD','Arizona'),
('Adetokunbo','Adeniyi','f','AdetokunboAdeniyi@yahoo.com','1995/6/12','Los Angeles','Colorado'),
('Qudus','Ademola','m','QudusAdemola@yahoo.com','1995/5/7','GREENWOOD','Idaho'),
('Chidinma','Nwankwo','f','ChidinmaNwankwo@gmail.com','1993/2/2','SIOUX FALLS','New York'),
('Chukwuemeka','Nnamani','m','ChukwuemekaNnamani@gmail.com','1990/2/2','Houston','Alaska'),
('Obinna','Eze','f','ObinnaEze@outlook.com','1986/10/12','Fort Worth','Georgia'),
('Jideofor','Oni','m','JideoforOni@gmail.com','1999/5/15','Oklahoma','newyork'),
('Jideofor','Oni','m','JideoforOni@gmail.com','1999/5/15','Texas','newyork'),
('moo','kevin','m','mokivin@gmail.com','1970/05/15','Athens','florida'),
('peter','peter','m','peter@gmail.com','1969/5/15','Huntsville','california')


--- insert 10 rows data to customer table
insert into Account (AccountNumber , AccountType, Balance,account_Status,CustomerId)
values (1001, 'saving',50500,'active',1 ),
(1002, 'current',5000,'active',2 ),
(1003, 'saving',70000,'active',3),
(1004, 'saving',1500,'active', 4),
(1005, 'current',56000,'active',5 ),
(1006, 'currnet',10000,'active', 6),
(1007, 'saving',44500,'active', 7),
(1008, 'current',50000,'active', 8),
(1009, 'currnet',19600,'active', 9),
(1010, 'currnet',9500,'active', 10)

--- insert types of transactions to Transactions table
insert into Transactions (TransactionType)
values ('Withdrawal'),
('Deposit'),
('Balance Inquiry'),
('Transfer')

--- insert data to department table 
insert into department (Dnumber,dname)
values(10,'D1'),
(20,'D2'),
(30,'D3')

--- insert data to Employee table 
INSERT INTO Employee(EmployeeId, FirstName, LastName, Salary, Position, SupervisorID, branchid, Dno)
VALUES
(1, 'mark', 'tomas', 10000, 'account', NULL, 1, 10),
(2, 'george', 'andro', 12000, 'engineer', 1, 2, 10),
(3, 'john ', 'mark ', 14000, 'engineer', 2, 3, 10),
(4, 'tony', 'justen', 11000, 'Hr', 2, 4, 10),
(5, 'robert', 'jack', 14000, 'iT', NULL, 5, 20),
(6, 'meshel', 'adam', 15000, 'admin', 5, 6, 20),
(7, 'skiler', 'beter', 3000, 'pr', 5, 7, 20),
(8, 'nancy', 'joee', 5000, 'sales', NULL, 8, 30),
(9, 'sara', 'whilem', 7000, 'office', 8, 9, 30),
(10, 'devid', 'geogre', 10000, 'manger it ', 8, 10, 30)


--- insert data to Customer_phones table 
insert into Customer_phones 
values (1,5628741234),
(2,5629753388),
(3,3109993628),
(4,7148473366),
(5,7149975885),
(6,7149972428),
(7,5625611921),
(8,7149688201),
(9,5627867727),
(10,5922565527)
--- insert data to branch table 
INSERT INTO Branch (BranchId, BranchName, Branch_Location) VALUES
(1, 'Alabama United Bank', 'Alabama'),
(2, 'Alaska United Bank', 'Alaska'),
(3, 'Arizona United Bank', 'Arizona'),
(4, 'Arkansas United Bank', 'Arkansas'),
(5, 'California United Bank', 'Colorado'),
(6, 'Delaware United Bank', 'Delaware'),
(7, 'Florida United Bank', 'Florida'),
(8, 'Hawaii United Bank', 'Hawaii'),
(9, 'Tennessee United Bank', 'Tennessee'),
(10, 'Texas United Bank', 'Texas')
GO


--- insert data to Loan table 
INSERT INTO Loan(LoanID,Amount,loan_months_terms,LoanType,Startdate,Enddate,Interestrate,CustomerId,BranchID)
VALUES
(001002, 116500, 42,'micro', '2022/10/2','2024/2/20',4.56,2, 1),
(001003, 206500, 104,'micro', '2022/1/1','2025/5/30',4.25,3, 2),
(001005, 406500, 45, 'macro', '2021/3/3','2022/8/20',4,7, 3),
(001006, 456500, 85,'macro', '2020/5/4','2023/2/22',3.99,9, 4),
(001008, 696500, 140,'micro', '2019/2/8','2023/9/9',4.5,1, 5),
(001011, 706500, 122,'micro', '2022/9/9','2026/9/9',4.125,4, 6),
(001013, 346500, 82,'macro', '2021/5/25','2024/2/2',4.875,10, 7),
(001014, 266500, 140,'micro', '2019/3/3','2023/10/9',3.49,5, 8),
(001018, 376500, 99,'sme', '2021/9/3','2024/12/9',4.375,8, 9),
(001020, 436500, 107,'sme', '2019/8/4','2023/2/9',3.625,6, 10)

--- insert data to ATM table 
insert into ATM (AtmId,Atm_location,Atm_status,BranchId)
values (200,'Alabama','withdawals',1),
(201,'Alaska','deposit',2),
(202,'Arizona','transfer',5),
 (203,'california','withdawals',3),
 (204,'newyork','withdawals',10),
 (205,'newyork','withdawals',3),
 (206,'mayami','withdawals',2),
 (207,'florida','withdawals',3),
 (208,'Arkansas','withdawals',1),
 (209,'California','deposit',4),
 (210,'Colorado','transfer',6),
 (211,'Connecticut','transfer',7),
 (212,'Delaware','deposit',8),
 (213,'District of Columbia','withdawals',9)

--- insert data to Account_Atm_transcation table
insert into Account_Atm_transcation (accountnumber, Atmid, Amount, transaction_type_id,transactiondate )
values(1001,200,5000, 1, '2023-8-19'),
(1001,201,2000, 2, '2023-8-19'),
(1002,201,3000, 2, '2023-8-19'),
(1003,210,0, 3, '2023-8-19'),
(1006,209,6000, 4, '2023-8-19'),
(1008,207,8000, 1, '2023-8-19'),
(1009,206,0, 3, '2023-8-19'),
(1007,205,1000, 4, '2023-8-19'),
(1001,204,10000, 1, '2023-8-19'),
(1005,203,20000, 1, '2023-8-19')
SELECT * FROM Account a
-- insert data to card_table 
insert into Card
values                 
 (19001,'credit','active','2024/12/31',1001),
 (19002,'credit','active','2024/12/31',1002),
 (19003,'credit','active','2024/12/31',1003),
 (19004,'debit','active','2024/12/31',1004),
 (19005,'credit','active','2024/12/31',1005),
 (19006,'debit','active','2024/12/31',1006),
 (19007,'debit','active','2024/12/31',1007),
 (19008,'credit','active','2024/12/31',1008),
 (19009,'debit','active','2024/12/31',1009),
 (19010,'credit','active','2024/12/31',1010)

 SELECT * FROM employee 
 SELECT * FROM account 
 SELECT * FROM Account_Atm_transcation 
 SELECT * FROM ATM 
 SELECT * FROM Branch 
 SELECT * FROM card 
 SELECT * FROM Customer_phones  
 SELECT * FROM Customers 
 SELECT * FROM Department  
 SELECT * FROM loan   
 SELECT * FROM Transactions  
 --------------------------------------end---------------------------------------

 --------------------------------------View------------------------------------------

----------------- to get employee details along with department name---------

CREATE OR ALTER VIEW EmployeeDetails 
AS
SELECT e.employeeid, concat (e.FirstName,' ',e.LastName) AS employee_name, e.salary, d.dname AS department_name
FROM Employee e JOIN Department d 
ON e.Dno = d.Dnumber
WHERE Dnumber=10

--test view query 

select * from EmployeeDetails 

------------------name of manager employee-----------------------------

create or alter view managerofemployee 
as
SELECT firstname,lastname,dname
FROM employee e JOIN department d
ON e.dno=D.dnumber
AND e.employeeid=D.mgrid

--test view query 

select * from managerofemployee  

--------view to count each transaction and display the sum of transactions-------

create or alter view most_transactions
as
  select transactionType, count(a.Transaction_Type_Id) as count_transactions 
  from Account_Atm_transcation a, Transactions t
  where a.TRANSACTION_type_ID = t.Transaction_Type_Id
  group by transactionType
  union all
  SELECT 'Sum_of_Transactions' Transaction_type_Id, count(Transaction_type_Id)
  FROM Account_Atm_transcation
 
--test view query 

SELECT * from most_transactions

-----------create a view to get customer and their account details
--with the availability loans amount---------

create view v_customer_acc_details 
As 
select c.CustomerId, phone , concat(c.FirstName,c.LastName) as "Full Name" 
,a.AccountNumber , balance , amount as "Loan Amount" 
from Customer_phones cp inner join customers c 
on cp.customerid = c.customerid
inner join account a 
on c.customerId = a.customerId, Customers cl 
inner join loan l 
on cl.customerId = l.customerId
group by c.CustomerId, phone,concat(c.FirstName,c.LastName), a.AccountNumber , balance , amount 

--test view query 

select * from v_customer_acc_details

-----------------------------------all customers info-------------------------------------

create OR ALTER view vw_customers_info 
as
select firstname,account_type,balance,opendate,account_status,age,city
from account a, customers s
where a.CustomerId=s.CustomerId

--test view query

select * from vw_customers_info

---------------------all customers balance more than 25000----------------------------------
create OR ALTER view vw_balance 
as
select balance , firstname
from Account a , Customers c
where a.CustomerId=c.CustomerId
and Balance >25000

--test view query

select * from vw_balance

--------------------------------Funcation-----------------------------

----------------Function to calculate total salary for each department --------

CREATE  OR ALTER FUNCTION cal_salary(@dnum INT)
RETURNS DECIMAL(10,2)
BEGIN
DECLARE @total DECIMAL(10,2)
SELECT  @total=SUM(salary)
FROM  employee 
WHERE Dno=@dnum
RETURN @total
END 

--test function query 

--select * from Employee
select dbo.cal_Salary(10) AS Total_Salary


---------Create Scalar function name GetEmployeeSupervisor------------------------ 
--Returns the name of an employee's supervisor based on their employeeid.---------

create or alter function getemployeesupervisor (@employeeid int) 
returns varchar(50)
 begin 
    declare @name varchar(50),@name2 VARCHAR(50)
  select @name=s.FirstName ,@name2=s.LastName
  from employee e join employee s
  on s.employeeid=e.supervisorid
  where e.employeeid=@employeeid
  return @name + ' '+ @name2
 end 

--test function query 

--select * from Employee
select dbo.getemployeesupervisor (2) as fullname


--------------create function Calculate Monthly payment ----------------

create or alter function dbo.CalculateMonthlypayment(
@interest_rate float,
@loan_amount float,
@loan_termmonths int,
@monthly_interestrate float)
returns float
as 
begin 
	set @monthly_interestrate = @interest_rate/(12*100) ;
	return ( @loan_amount*@monthly_interestrate) / (1 - power(1+ @monthly_interestrate,-@loan_termmonths)) ;
End;

--test function query 

select dbo.CalculateMonthlypayment(4.56,116500,42,0.0038) as [Monthly Loan Payment] 

-----------------create function calculate Interest Amount -------------------------

create function dbo.calculateInterestAmount(@loan_amount float,@interest_rate float,@loan_termmonths int)
returns float
as
begin
	return @loan_amount*(@interest_rate/(12*100))*@loan_termmonths
end;

--test function query 

select dbo.calculateInterestAmount(1000,10,12) as [Interest Amount]


---------------------------------all customers data------------------------------

create OR ALTER function Getallcustomers(@acc_id int)
returns table 
return 
select accounttype,balance,opendate,account_status,firstname,age,city
from account a, customers s
where a.CustomerId=s.CustomerId

---test function query

select * from Getallcustomers(1001)
 
 
 -----------------------function to getalldataabout info----------------------------
 
 create or alter function getinfo()
 returns table 
 return 
 select phone , email,FirstName
 from Customer_phones cp, Customers c
 where c.CustomerId=cp.CustomerId

 --test funtion query 
 
 select * from getinfo()

----------------Create table function to return loan customer data-------------------

create OR ALTER  FUNCTION loan_customer_data (@id INT )
RETURNS TABLE
AS
RETURN
(
--DECLARE @loanid INT ,@firstname varchar(150),@Amount FLOAT,@interestrate FLOAT  
Select L.loanId,c.firstname,l.Amount,L.Interestrate
from loan l join Customers c
ON  c.customerId =l.customerid
WHERE c.customerId= @id   
)
--test view query 

select * from loan_customer_data (2)


---------------------------------------Procedure---------------------------------------------

---------------------Procedure to count employees in each department------------------------------

create or alter proc total_of_num 
as
select count(e.employeeid) as count_num,d.DName
from employee e join Department d
on e.Dno= d.dnumber
group by d.dname

--test proc query 

execute total_of_num 

-------------proc that return the transactions that specific customer had done------------------

CREATE OR ALTER proc get_customer_transaction @account_nu INT, @trans_date DATE
AS
    begin
    if EXISTS (SELECT * FROM Account_Atm_transcation WHERE accountnumber = @account_nu)
    begin
        SELECT transactiondate, accountnumber,a.transactionid,Atmid
		,Amount,a.transaction_type_id, TransactionType
        FROM Account_Atm_transcation a join Transactions t
		on a.TRANSACTION_type_ID = t.Transaction_Type_Id
        WHERE a.accountnumber = @account_nu
        AND a.transactiondate = @trans_date	
    END
    ELSE
    BEGIN
        PRINT 'This id is invalid'
end
        RETURN 
    END 
--test proc query

--SELECT * FROM Account 
EXECUTE get_customer_transaction 1002, '2023-08-19'

----------proc that return the amount of money of specific transaction type-------------

create or alter proc total_amount_of_specific_transaction @transaction_type varchar(20)
as 
select t.transactionType,a.TRANSACTION_type_ID ,sum(amount) as sum_amount_transaction
from transactions t, Account_Atm_transcation a
where a.TRANSACTION_type_ID = t.Transaction_Type_Id 
and transactionType =  @transaction_type
group by transactionType, a.Transaction_Type_Id

--test proc query 

--SELECT * FROM Account_Atm_transcation aat 
EXECUTE total_amount_of_specific_transaction 'Withdrawal'

------------Create a stored procedure to add "Dear" as a prefix to customer's name.-------------------- 

CREATE OR ALTER PROCEDURE sp_Update_customer 
@customerId int
AS
UPDATE customers 
SET Firstname = Concat('Dear' , ' ' , FirstName)
where CustomerId = @customerId 

--test proc query 

--SELECT * FROM customers

EXEC sp_Update_customer 1;
  
---------Create a stored procedure that accepts AccountId as a parameter 
--and returns customer's full name and account's details.--------- 

create PROCEDURE sp_Customer_Details @AccountNumber INT
AS
SELECT c.firstname +' ' +c.lastname AS Customer_full_name , a.accountNumber ,a.balance 
FROM Customers c
JOIN Account a
ON c.customerID = a.customerId
WHERE a.accountNumber = @AccountNumber;

--test proc query

EXEC sp_Customer_Details 1001;

-------------Write a procedure query to remove cstate column from Customer table. -----------------------

CREATE PROCEDURE sp_Remove_Column
AS
ALTER TABLE Customers
DROP COLUMN state

--test proc query      $danguer$   $danguer$   $danguer$   $danguer$   $danguer$ 

EXEC sp_Remove_Column;

-----------------------stored about customers their accounts are saving-----------------------

create or alter proc get_allsaving 
as
(
select firstname,accounttype,balance,age
from Customers c ,Account a
where c.CustomerId=a.CustomerId
and accounttype='saving'
)

get_allsaving

----------------------------------current------------------------------
create proc getallcurrent as 
(
select firstname,accounttype,balance,age
from Customers c ,Account a
where c.CustomerId=a.CustomerId
and accounttype='current'
)

getallcurrent

-------------------------------credit--------------------------------------------
 create or alter proc getallcredit 
 as 
 select cardtype,firstname , accounttype 
 from card ca ,customers c , account a 
 where ca.accountnumber=A.accountnumber
 and A.customerid=c.customerid
 and cardtype='credit'

 getallcredit

----------------------------------debit---------------------------------
 create or alter proc getalldebit 
 as 
 select cardtype,firstname , accounttype 
 from card ca ,customers c , account a 
 where ca.accountnumber=A.accountnumber
 and A.customerid=c.customerid
 and cardtype='debit'

 getalldebit


---------------------------------------Trigger-----------------------------------------------------

----------------------Trigger to update last_updated column when an employee is updated---------------

ALTER TABLE employee 
ADD last_updated DATETIME
    
CREATE OR ALTER TRIGGER UpdateEmployeeLastUpdated
ON Employee
AFTER UPDATE
as
BEGIN
    UPDATE Employee
    SET last_updated = GETDATE()
	FROM employee e,INSERTED i
    WHERE e.employeeid = i.employeeid;
END

--test trigger query 

UPDATE employee 
SET salary+=200000
WHERE employeeid=1

SELECT * FROM employee 

---------------------Trigger that update balance depend on the transaction type----------------------

create or alter trigger update_balance
on Account_Atm_transcation
after insert 
AS

 if exists (select transaction_Type_id from inserted where transaction_Type_id=1)

 begin 
 declare @amount float, @account_no int
 select @amount = amount, @account_no = Accountnumber from inserted
 update Account
 set balance -= @amount where Accountnumber = @account_no
 END

 else if exists(select transaction_Type_id from inserted where transaction_Type_id=2)

 begin 
 select @amount = amount, @account_no = Accountnumber from inserted
 update Account
 set balance += @amount where Accountnumber = @account_no
 end

--test trigger query 

 insert into Account_Atm_transcation
 values ('2023-8-19',1001,1,200,500)

 --select* from Account
 -----------------------------------index------------------------------------------

CREATE NONCLUSTERED INDEX idx_CustomerID ON Account (Balance)

CREATE UNIQUE INDEX uni_accountnumber ON account (accountnumber) 
--SELECT * FROM account
SELECT * FROM Customers 
----------------------------------cursor----------------------------------------------
declare c9 cursor
for
	select FirstName,gender
	from customers
for update 
declare @N varchar(100), @G varchar(10)
open c9
fetch c9 into  @N, @G
WHILE @@fetch_status=0
begin
    if (@G = 'm' )
		BEGIN
		update Customers 
		set FirstName = 'Mr.'+@N
		WHERE CURRENT OF c9
		END
	else if (@G = 'f' )
		BEGIN
		update customers 
		set FirstName = 'Mrs.'+@N
		WHERE CURRENT OF c9
		END
fetch c9 into  @N, @G
end
close c9
deallocate c9

--test  cursor query 

SELECT * FROM customers 

----------------------------------default--------------------------------------
create default def1 as 5000

sp_bindefault  def1,'Employee.salary'

--test default query 

SELECT * FROM employee
----------------------------------rules-----------------------------------------
create rule r1 as @x>1000
sp_bindrule  r1,'Employee.salary'

--test rules query 

SELECT * FROM employee

--------------------------------------cte---------------------------------------------------
-------------CREATE cte employee salary greather  than 45000 and his department name--------------

 WITH CTE_Employee 
 AS 
 ( SELECT FirstName, LastName,  Salary,d.dname
 FROM Employee e JOIN department d 
 ON d.Dnumber= e.Dno
WHERE Salary > '45000' )
--run cte 
SELECT FirstName, LastName,Dname
FROM CTE_Employee

--SELECT * FROM employee 

---------------------------------------case-----------------------------------------------
----------------------create case on age to return baby,young,old-------------------------
SELECT FirstName, LastName, Age,  
CASE 
WHEN Age > 30 THEN 'Old' 
WHEN Age BETWEEN 27 AND 30 THEN 'Young' 
ELSE 'Baby'
END AS description_Age
FROM Customers 
WHERE Age IS NOT NULL 
ORDER BY age
-------------------------------------rank----------------------------------
SELECT *, dense_RANK() OVER(PARTITION BY Dno ORDER BY Salary ) AS employe_rank
FROM Employee 
ORDER BY Dno, Salary

--test
SELECT * FROM employee

-----------------------------------top -------------------------           
select top 2 * from employee  
-----------------------------------like -------------------------
select * from employee e 
where firstname like '_k%'
-----------------------------------end--------------------------------


