Lab - 02

01. --create dummy type
create type dept_t1
/

--using dat dummy type, we can create dat employee type
create type emp_t1 as object(
	empno char(6),
	firstname varchar(12),
	lastname varchar(15),
	workdept ref dept_t1,
	sex char(1),
	bdate date,
	salary number(8,2)
)

create type dept_t1 as object (
	deptNo char(3),
	deptname varchar(36),
	mgrno ref emp_t1,
	admrdept ref dept_t1
)
/

create table empIT1 of emp_t1 (
	constraint emp_pk primary key (empno),
	constraint emp_fName firstname not null,
	constraint emp_lName lastname not null,
	constraint emp_check check(sex = 'M' or sex = 'F')
)
/

create table deptIT1 of dept_t1 (
	constraint dept_pk1 primary key(deptNo),
	constraint dept_NameNull1 deptname not null,
	constraint dept1_fk1 foreign key (mgrNo) references empIT1,
	constraint dept1_fk2 foreign key (admrdept) references deptIT1
)

alter table empIT1
add constraint emp_fk2 foreign key (workdept) references deptIT1



create type dept_t1 as object (
	deptNo char(3),
	deptname varchar(36),
	mgrno ref emp_tIT1,
	admrdept ref dept_t1
)

create type emp_tIT1 as object(
	empno char(6),
	firstname varchar(12),
	lastname varchar(15),
	workdept ref dept_t1,
	sex char(1),
	bdate date,
	salary number(8,2)
)

--insert values
insert into deptIT1 values ( 
dept_t1('A00', 'SPIFFY COMPUTER SERVICE DIV.', null, null)
)
/

insert into deptIT1 values ( 
dept_t1('B01', 'PLANNING.', null, (select ref(a) from deptIT1 a where a.deptNo = 'A00'))
)
/

insert into deptIT1 values ( 
dept_t1('C01', 'INFORMATION CENTRE ', null, (select ref(a) from deptIT1 a where a.deptNo = 'A00'))
)
/

insert into deptIT1 values ( 
dept_t1('D01', 'DEVELOPMENT CENTRE', null, (select ref(a) from deptIT1 a where a.deptNo = 'C01'))
)
/

update deptIT1 c
set c.admrdept = (select ref(c) from deptIT1 c where c.deptNo = 'A00')
where c.deptNo = 'A00'

insert into empIT1 values (
	emp_t1('000010', 'CHRISTINE', 'HAAS', 'F', '14-AUG-53', 72750)
)
/

INSERT INTO empIT1 VALUES (
	emp_t1('000010')
)

insert into empIT1 values ( 
emp_t1('000010', 'CHRISTINE', 'HAAS', (select ref(D) from deptIT1 D where D.deptNo = 'C01'),'F', '14-aug-02', 72750)
)
/
insert into empIT1 values ( 
emp_t1('000020', ' MICHAEL', 'THOMPSON', (select ref(D) from deptIT1 D where D.deptNo = 'B01'),'M', '10-feb-12', 61250)
)
/
insert into empIT1 values ( 
emp_t1('000030', ' SALLY', 'KWAN', (select ref(D) from deptIT1 D where D.deptNo = 'A01'),'F', '11-may-22', 58250)
)
/
insert into empIT1 values ( 
emp_t1('000060', ' IRVING', 'STERN', (select ref(D) from deptIT1 D where D.deptNo = 'D01'),'M', '11-jul-65', 55555)
)
/

insert into empIT1 values ( 
emp_t1('000070', ' EVA', 'PULASKI', (select ref(D) from deptIT1 D where D.deptNo = 'D01'),'F', '11-may-55', 56170)
)
/

insert into empIT1 values ( 
emp_t1('000050', ' JOHN', 'GEYER', (select ref(D) from deptIT1 D where D.deptNo = 'C01'),'M', '11-sep-72', 60175)
)
/

SELECT D.deptname, D.mgrno.lastname AS manager
FROM deptIT1 D
/

SELECT E.empno, E.lastname, E.workdept.deptname AS deptname
FROM empIT1 E
/

SELECT D.deptno,D.deptname, D.admrdept.deptname AS admrname
FROM deptIT1 D
/

SELECT D.deptno, D.deptname, D.admrdept.deptname AS admrname, 
		D.admrdept.mgrno.lastname AS admanager
FROM deptIT1 D
/

SELECT E.empno, E.firstname, E.lastname, E.salary,
		E.workdept.mgrno.lastname AS manager,
		E.workdept.mgrno.salary AS mgrsal
FROM empIT1 E
/

SELECT E.workdept.deptno AS deptno,
		E.workdept.deptname AS deptname,
		E.sex, AVG(E.salary) AS avgsal
FROM empIT1 E
GROUP BY E.workdept.deptno, E.workdept.deptname
/
