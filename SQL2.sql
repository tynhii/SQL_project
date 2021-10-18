use COMPANY
go

--Tên nhân viên trong phòng số 1/ 
select EName
from EMPLOYEE
where dnum=1
go
--Ten nv trong phòng phần meem trong nươc          <JOINT TABLE>

/*CÁCH 1*/
select EName
from EMPLOYEE, DEPARTMENT --105(12)
where DName=N'Phòng phần mềm trong nước' and DNum=DNumber
go
-- 210 so sánh
/*CÁCH 2*/
select EName
from EMPLOYEE join DEPARTMENT on DNum=DNumber --21(12)
where DName=N'Phòng phần mềm trong nước'
go
--126 so sánh
/*CÁCH 3*/
SELECT EName
FROM EMPLOYEE JOIN 
  (SELECT * FROM DEPARTMENT 
     WHERE DName=N'Phòng phần mềm trong nước') D --5(12)
   ON DNum=D.DNumber
GO 
-- 26 so sánh
-- Tên trưởng phòng số 1
select EName, mgrSSN
from EMPLOYEE, DEPARTMENT
where DNumber=1 and mgrSSN=ESSN
go
--tên đơn vị quản lý dự án tại tp hcm
select DName
from PROJECT, DEPARTMENT
where  DNum=DNumber and PLocation=N'TP. Hồ Chí Minh'
go
-- tên dự án có sự tham gia của võ việt anh
select pName, EName
from EMPLOYEE,PROJECT, WORKSON
where PNum=PNumber and EName=N'Võ Việt Anh'
and WORKSON.ESSN=EMPLOYEE.ESSN
go

select pName, EName
from EMPLOYEE E,PROJECT P, WORKSON W
where PNum=PNumber and EName=N'Võ Việt Anh'
and W.ESSN=E.ESSN
go
--liệt kê tên nv và tên của đơn vị của người đó
select EName, DName
 from EMPLOYEE, DEPARTMENT
 where DNum=DNumber
 go

 select EName, DName
 from EMPLOYEE join DEPARTMENT on DNum=DNumber 
 go

-- mã số nhân viên tham gia dự án 1 vầ dự án 2

-- tìm nv có lương cao nhất

select EName
from EMPLOYEE 
where ESalary>= all(select ESalary from EMPLOYEE)
go
