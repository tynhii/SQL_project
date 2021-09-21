
use COMPANY
go
/*1- Tạo view thể hiện tên, tuổi, đơn vị công tác của mỗi nhân viên*/
create view view1 as 
	SELECT EName as 'Tên',YEAR(getdate())-YEAR(EBirthdate)as 'Tuổi' ,DNum as 'Đơn vị công tác'
	FROM EMPLOYEE  join DEPARTMENT 
	on DNum=DNumber
go

/*2- Tạo view thể hiện tên đơn vị và tên trưởng đơn vị đó*/
create view view2 as 
SELECT EName AS 'Tên trưởng đv', DName as 'Tên đơn vị'
FROM EMPLOYEE JOIN DEPARTMENT ON DNum=DNumber
where mgrSSN=ESSN
go

/*3- Tạo view thể hiện tên, địa điểm thực hiện của các dự án do đơn vị số 1 quản lý*/
create view view3 as 
select PLocation as 'dia diem thuc hien du an', PName as 'ten du an'
from PROJECT join DEPARTMENT on DNum=DNumber
where DNumber=1
go

/*4- Tạo view thể hiện mã số nhân viên, thời gian tham gia của họ trong dự án số 1*/
create view view4 as 
select w.ESSN as 'MSNV', workHours as 'tg thuc hien'
from EMPLOYEE E, WORKSON w, PROJECT
where e.ESSN= w.ESSN and PNum=PNumber and PNumber=1
go

/*5- Tạo view thể hiện mã số, tên của đơn vị và số lượng nhân viên của đơn vị đó*/
create view view5 as 
select DNumber as 'ms', DName as 'ten dv' ,count(*) as 'so luong nv'
from EMPLOYEE, DEPARTMENT
where DNum=DNumber and 1=1
group by DNumber, DName
go