--- (1) ---
--Create dummy type/incomplete type--
create type dept_t
/
--Create emp_t UDT(user define type)--
create type emp_t as object (
	empno char(6),
	firstname varchar(12),
	lastname varchar(15),
	workdept REF dept_t,
	sex char(1),
	bdate date,
	salary number(8,2)
)
/
--Create dept_t as Complete type--
create type dept_t as object (
	deptno char(3),
	firstname varchar(36),
	mgrno ref emp_t,
	admrdept ref dept_t
)
/
--Create emp table--
create table emp of emp_t (
	constraint emp_PK primary key(empno),
	constraint emp_FirstName firstname not null,
	constraint emp_LastName lastname not null,
	constraint emp_Sex_CK check
		(sex = 'M' or sex = 'F' or sex = 'm' or sex = 'f')
)
/
--Create dept table--
create table dept of dept_t (
	constraint dept_PK primary key(deptno),
	constraint dept_Name firstname not null,
	constraint dept_MGRNO_FK foreign key(mgrno)references emp,
	constraint dept_ADMINdept_FK foreign key(admrdept)references dept
)
/
--Update FK constraint in emp table--
alter table emp
add constraint emp_PK1 foreign key(workdept) references dept
/
----Insert values----
insert into dept values
(dept_t ('A00', 'SPIFFY COMPUTER SERVICE DIV', null, null))
/
insert into dept values 
(dept_t('B01', 'PLANNING', null, 
			(select ref (D)
			from dept D
			where D.deptno = 'A00')))
/
insert into dept values 
(dept_t('C01', 'INFORMATION CENTRE ', null, 
			(select ref (D)
			from dept D
			where D.deptno = 'A00')))
/
insert into dept values 
(dept_t('D01', 'DEVELOPMENT CENTRE ', null, 
			(select ref (D)
			from dept D
			where D.deptno = 'C01')))
/
--Update--coomt
update dept D
set D.admrdept = (select ref(D)
					from dept D
					where D.deptno = 'A00')
where D.deptno = 'A00'
/

select * from dept

--- Insert Emp values ---

insert into emp values(emp_t('000010', 'CHRISTINE', 'HAAS', 
		(select ref (D) 
		from dept D
		where D.deptno = 'A00'), 'F', '14-AUG-53', '72750'))
/

insert into emp values(emp_t('000020', 'MICHEL', 'THOMSON', 
		(select ref (D) 
		from dept D
		where D.deptno = 'B01'), 'M', '02-FEB-68', '61250'))
/
insert into emp values(emp_t('000030', 'SALLY', 'KWAN ', 
		(select ref (D) 
		from dept D
		where D.deptno = 'C01'), 'F', '11-MAY-71', '58250'))
/
insert into emp values(emp_t('000060', 'IRVING', 'STERN ', 
		(select ref (D) 
		from dept D
		where D.deptno = 'D01'), 'M', '07-JUL-65', '55555'))
/
insert into emp values(emp_t('000070', 'EVA', 'PULASKI', 
		(select ref (D) 
		from dept D
		where D.deptno = 'D01'), 'F', '26-MAY-73', '56170'))
/
insert into emp values(emp_t('000050', 'JOHN', 'GEYER ', 
		(select ref (D) 
		from dept D
		where D.deptno = 'C01'), 'M', '15-SEP-55 ', '60175'))
/
insert into emp values(emp_t('000090', 'EILEEN', 'HENDERSON', 
		(select ref (D) 
		from dept D
		where D.deptno = 'B01'), 'F', '15-SEP-55', '49750'))
/
insert into emp values(emp_t('000100', 'THEODORE', 'SPENSER', 
		(select ref (D) 
		from dept D
		where D.deptno = 'B01'), 'M', '18-DEC-76', '46150'))
/
--- Update table ---

update dept D
set D.mgrno = (select ref(e)
				from emp e 
				where e.empno = '000010')
where D.deptno = 'A00'
/
update dept D
set D.mgrno = (select ref(e)
				from emp e 
				where e.empno = '000020')
where D.deptno = 'B01'
/
update dept D
set D.mgrno = (select ref(e)
				from emp e 
				where e.empno = '000030')
where D.deptno = 'C01'
/
update dept D
set D.mgrno = (select ref(e)
				from emp e 
				where e.empno = '000060')
where D.deptno = 'D01'
/

--- (2) ---
-- a --
select d.firstname, d.mgrno.lastname as Manager02
from dept D
/
-- b --
select e.empno, e.lastname, e.workdept.firstname as Deptname
from emp E
/
-- c --


-- d --
select d.deptno, d.firstname, d.admrdept.firstname as AdmName,
		d.admrdept.mgrno.lastname as AdmName
from dept D
/
-- e --
select e.empno, e.firstname, e.lastname, e.salary,
		e.workdept.mgrno.lastname as Manager,
		e.workdept.mgrno.salary as Manager
from emp E
/
-- f --
select e.workdept.deptno as DeptNO,
		e.workdept.firstname as DeptName,
		e.sex, Avg(e.salary) as AVGSal
from emp E
group by e.workdept.deptno, e.workdept.firstname, e.sex
/













	
			


		





