use COMPANY
go
--Tạo view có tên <MSSV>_View01 để cung cấp thông tin về mã số, họ tên, giới tính, mã số đơn vị của các nhân viên tham gia dự án số 1

IF OBJECT_ID ('030234180095_View01','v') is not null
	drop view [030234180095_View01]
go

create view [030234180095_View01] as 
	select e.ESSN as 'MSNV', EName as 'Ho ten', ESex as 'Gioi tinh', e.DNum as 'MSDV'
	from EMPLOYEE e, WORKSON w
	where PNum=1 and e.ESSN=w.ESSN
go

--Tạo view có tên <MSSV>_View02 để cung cấp thông tin về họ tên, giới tính, mã số đơn vị của các nhân viên nữ có lương từ 45000 trở lên.

IF OBJECT_ID ('030234180095_View02','v') is not null
	drop view [030234180095_View02]
go

create view [030234180095_View02] as 
	select EName as 'Ho ten', ESex as 'Gioi tinh', DNum as 'MSDV'
	from EMPLOYEE
	where ESex='F' and ESalary>=45000
go

--Tạo thủ tục có tên <MSSV>_Pro03 để cập nhật thông tin về thu nhập của nhân viên với mã số nhân viên và thu nhập là hai tham số đầu vào.

IF OBJECT_ID ('030234180095_Pro03','P') is not null
	drop procedure [030234180095_Pro03];
go
create procedure [030234180095_Pro03]
	@essn decimal(18,0),
	@esalary int
as
	update EMPLOYEE
	set ESalary=@esalary
	where ESSN=@essn
go

--Tạo thủ tục có tên là <MSSV>_Pro04 để tính tổng thu nhập của đơn vị với mã số đơn vị là tham số đầu vào, tổng thu nhập là tham số đầu ra.v

IF OBJECT_ID ('030234180095_Pro04','P') is not null
	drop procedure [030234180095_Pro04]
go

create procedure [030234180095_Pro04]
	@dnum int,
	@esalary output int
as
	select @esalary=sum(ESalary)
	from EMPLOYEE
	where DNum=@dnum

go

--Tạo trigger có tên <MSSV>_Trig01 hủy bỏ việc thêm/sửa trên bảng Department

IF OBJECT_ID ('030234180095_Trig01','tr') is not null
	drop trigger [030234180095_Trig01]
go
create trigger [030234180095_Trig01] on Department
after insert,update
as
rollback
go




