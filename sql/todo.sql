-- Sa se creeze tabelele si legaturile dintre acestea conform modelului specificat
Create database TRAINING;
use TRAINING;
Create table PERSON( CNP Varchar(13),
		name varchar(100),
		DOB date,
		gender varchar(10),
		Birth_place text,
		Primary key(CNP));
Create table FACULTY(faculty_id int AUTO_INCREMENT,
		name varchar(50),
		Primary key(faculty_id));
Create table STUDENT(CNP varchar(13),
			faculty_id int,
			student_id int,
			primary key(student_id),
			foreign key(CNP) references PERSON(CNP),
			foreign key(faculty_id)  references FACULTY(faculty_id));
Create table DEPT(dept_no int auto_increment,
		name varchar(50),
		location text null,
		primary key(dept_no));
Create table EMP(emp_no int auto_increment,
		cnp varchar(13),
		dept_no int,
		manager int null,
		emp_date date,
		sal numeric(18,2),
		com numeric(18,2)  null,
		Primary key(emp_no),
		Foreign key(CNP) references PERSON(CNP),
		Foreign key(dept_no) references DEPT(dept_no),
		Foreign key(manager) references EMP(emp_no));
Create table SAL_GRADE(id int,
			min_sal numeric(18,0),
			max_sal numeric(18,0));
-- Sa se adauge cate 5 intrari in fiecare tabela

INSERT INTO FACULTY (NAME) VALUES ('ACS');
INSERT INTO FACULTY (NAME) VALUES ('FILS');
INSERT INTO FACULTY (NAME) VALUES ('ETTI');
INSERT INTO FACULTY (NAME) VALUES ('FIIR');
INSERT INTO FACULTY (NAME) VALUES ('Aerospatiala');

INSERT INTO DEPT (NAME, LOCATION) VALUES ('SALES', 'MALUL DUNARII');
INSERT INTO DEPT (NAME) VALUES ('IT');
INSERT INTO DEPT (NAME) VALUES ('PR');
INSERT INTO DEPT (NAME) VALUES ('HR');
INSERT INTO DEPT (NAME) VALUES ('Design');

INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (1, 1000, 2000);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (2, 2000.01, 5000.42);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (3, 5000.68, 5000.77);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (4, 5000.78, 500000);
INSERT INTO SAL_GRADE (ID, MIN_SAL, MAX_SAL) VALUES (5, 500000.01, 1000000);

INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('1000000000123', 'AUREL', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'MALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('2000000000523', 'GICA', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'FEMALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('1000000030113', 'BANEL', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'MALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('1000003000123', 'FAGURAS', STR_TO_DATE('01/01/1900', '%d/%m/%Y'), 'MALE', 'CANAL');
INSERT INTO PERSON (CNP, NAME, DOB, GENDER, BIRTH_PLACE) VALUES
	('2991027370012', 'ILEANA', STR_TO_DATE('01/10/1999', '%d/%m/%Y'), 'FEMALE', 'CANAL');

INSERT INTO STUDENT(CNP, FACULTY_ID, student_id) VALUES ('1000003000123', 1,1);
INSERT INTO STUDENT(CNP, FACULTY_ID, student_id) VALUES ('2991027370012', 1,2);
INSERT INTO STUDENT(CNP, FACULTY_ID, student_id) VALUES ('1000000030113', 2,3);
INSERT INTO STUDENT(CNP, FACULTY_ID, student_id) VALUES ('1000003000123', 3,4);
INSERT INTO STUDENT(CNP, FACULTY_ID, student_id) VALUES ('1000000000123', 4,5);

INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('1000000000123', 1, NULL, STR_TO_DATE('30/12/1999', '%d/%m/%Y'), 15000, NULL);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('2000000000523', 1, 1, STR_TO_DATE('30/12/2000', '%d/%m/%Y'), 1500, NULL);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('1000000030113', 3, 1, STR_TO_DATE('30/12/2004', '%d/%m/%Y'), 3000, 11.02);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('1000003000123', 4, 3, STR_TO_DATE('30/12/2020', '%d/%m/%Y'), 2000, 15.72);
INSERT INTO EMP(CNP, DEPT_NO, MANAGER, EMP_DATE, SAL, COM)
	VALUES ('2991027370012', 2, 2, STR_TO_DATE('15/04/2001', '%d/%m/%Y'), 1500, NULL);
-- Sa se afiseze toate intrarile din fiecare tabela

SELECT  * from DEPT;
SELECT  * from PERSON;
SELECT  * from EMP;
SELECT  * from FACULTY;
SELECT  * from SAL_GRADE;
SELECT  * from STUDENT;

-- Sa se afiseze toate persoanele de un anumit sex

Select * from PERSON
where gender like 'MALE';
-- Sa se afiseze toti angajatii din departamentul cu id-ul 3

SELECT * from EMP
where  dept_no = 3;
-- Nume ang dep 3
select name
from PERSON
join EMP on PERSON.CNP = EMP.cnp
where dept_no =3;

-- Sa se actualizeze la alegere o intrare din orice tabela
UPDATE  SAL_GRADE
set min_sal = 1000
where id = 1;

-- Sa se stearga o intrare din tabela SAL_GRADE
-- Sa se stearga tabela SAL_GRADE
-- Sa se refaca tabela SAL_GRADE (copiati ce ati scris anterior)
-- Sa se gaseasca toti angajatii de sex feminin
SELECT  P.name
from PERSON P join EMP E on P.CNP = E.cnp
where P.gender like 'FEMALE';
-- Sa se gaseasca angajatii din departamentul cu numele 'IT'

select *
from EMP E join DEPT D on E.dept_no = D.dept_no
where D.name like 'IT';
-- Sa se gaseasca id-urile tuturor studentilor care sunt si angajati

SELECT student_id
from STUDENT natural join EMP;
-- Sa se gaseasca id-urile tuturor studentilor care sunt angajati in departamentul 'IT'
Select student_id
from STUDENT S join EMP E on S.CNP = E.cnp
join DEPT D on E.dept_no = D.dept_no
where  D.name like 'IT';

-- Sa se gaseasca numarul total de persoane

SELECT COUNT(*)
FROM PERSON;

-- Sa se afiseze gradul salarial, valorile acestuia si salariul total  pentru fiecare angajat, luand in calcul si comisionul ordonati crescator dupa EMP_ID

SELECT 	G.ID AS 'ID',
	G.MIN_SAL,
	G.MAX_SAL,
	E.SAL + IFNULL(E.COM, 0) 'VENIT'
FROM 	EMP E
JOIN 	SAL_GRADE G ON	E.SAL+IFNULL(E.COM, 0)<MAX_SAL AND
			E.SAL+IFNULL(E.COM, 0)>MIN_SAL
ORDER BY E.EMP_NO ASC;

drop database TRAINING;
