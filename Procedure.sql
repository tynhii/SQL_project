
USE COMPANY
GO

/*1- Tạo thủ tục lsDepartmentByID hiển thị tên đơn vị với tham số đầu vào là mã số đơn vị */
IF OBJECT_ID ('sp_lsDepartmentByID','P') is not null
	drop procedure sp_lsDepartmentByID;
go
create procedure sp_lsDepartmentByID
	@dname nvarchar(50) output,
	@dnumber int=1
as
	select DName
	from DEPARTMENT
	where @dnumber=DNumber;
go
exec sp_lsDepartmentByID 1
go
--exec lsDepartmentByID 1
--go
--DName
--Phòng Phần mềm trong nước

/*2- Tạo thủ tục lsManager hiển thị tên trưởng đơn vị với tham số đầu vào là mã số đơn vị */
--exec lsManager 1
--go
--EName
--Võ Việt Anh
IF OBJECT_ID ('sp_lsManager','P') is not null
	drop procedure sp_lsManager;
go
create procedure sp_lsManager
	@ename nvarchar (50) output,
	@dnumber int=1
as
	select EName
	from EMPLOYEE, DEPARTMENT
	where DNum=DNumber and mgrSSN=ESSN and @dnumber=DNumber;
go
exec sp_lsManager 1
go

/*3- Tạo thủ tục lsDepartmentByProject hiển thị tên đơn vị quản lý dự án X với X là tên dự án được truyền vào như tham số*/
--exec lsDepartmentByProject N'ProjectA'
--go
--DName
--Phòng Giải pháp mạng truyền thông
IF OBJECT_ID ('sp_lsDepartmentByProject','P') is not null
	drop procedure sp_lsDepartmentByProject;
go
create procedure sp_lsDepartmentByProject
	@dname nvarchar (50) output,
	@pname nvarchar(50)=pname
as
	select DName
	from PROJECT, DEPARTMENT
	where DNum=DNumber and PName=@pname;
go
exec sp_lsDepartmentByProject N'ProjectA'
go
/*4- Tạo thủ tục findBestPayeeInDepartment hiển thị tên nhân viên có lương cao nhất trong đơn vị với tham số đầu vào là mã số đơn vị*/
--exec findBestPayeeInDepartment 1
--go
--EName
--Võ Việt Anh
IF OBJECT_ID ('sp_findBestPayeeInDepartment','P') is not null
	drop procedure sp_findBestPayeeInDepartment;
go
create procedure sp_findBestPayeeInDepartment
	@ename nvarchar (50),
	@dnum int=1
as
	select EName
	from EMPLOYEE
	where ESalary>=all(select ESalary from EMPLOYEE);
go
exec sp_findBestPayeeInDepartment 1
go
/*5- Tạo thủ tục findNoOfEmployeesInProject hiển thị số lượng nhân viên của mỗi đơn vị trong dự án X với X là mã số dự án được truyền vào như tham số*/
--exec findNoOfEmployeesInProject 1
--go
--DNum	NoOfEmployees
--1		3
--3		4
IF OBJECT_ID ('sp_findNoOfEmployeesInProject','P') is not null
	drop procedure sp_findNoOfEmployeesInProject;
go
create procedure sp_findNoOfEmployeesInProject
	@Noworker int output,
	@pnumber int=1
as
	select @Noworker=count(*)
	from WORKSON w where w.PNum=@pnumber;
go
declare @numberofworker int
exec sp_findNoOfEmployeesInProject 1
