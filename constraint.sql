SELECT constraint_name, table_schema, table_name, constraint_type
    FROM information_schema.table_constraints
    WHERE constraint_schema = 'sample';

-- notnull
CREATE table dept_n1(
  	deptno int(2) not null,
    	dname varchar(14),
    	loc varchar(13)
  );
  desc dept_n1;

INSERT INTO dept_n1 values(10,'개발부', '서울');

INSERT INTO dept_n1(deptno, dname) values (20,'개발부');

INSERT INTO dept_n1 values(30,'개발부',null);

SELECT * from dept_n1;

--unique 컬럼조건
CREATE table dept_u1(
  	deptno int(2) unique,
    	dname varchar(14),
    	loc varchar(13)
  );

  
INSERT INTO dept_u1 values(10,'개발부','서울');
INSERT INTO dept_u1 values(20,'연구부','대전');
-- duplicate entry 값 for key 열이름 -> 중복값 에러

-- unique 테이블조건
CREATE table dept_u2(
  	deptno int(2),
    dname varchar(14),
    loc varchar(13),
    constraint unique(deptno)
  );

--기본키 컬럼조건
CREATE table dept_p1(
  	deptno int(2) primary key,
    dname varchar(14),
    loc varchar(13)
  );

--기본키 테이블조건
CREATE table dept_p2(
  	deptno int(2),
    dname varchar(14),
    loc varchar(13),
    constraint primary key(deptno)
  );

-- 자동증가 기본키
-- primary key인 value값에 0을 넣으면 최고값+1로 자동으로 들어간다
CREATE table dept_a1(
  	deptno int(2) primary key auto_increment,
    dname varchar(14),
    loc varchar(13)
  );

CREATE table dept_p(
	deptno int(2) primary key,
    dname varchar(14),
    loc varchar(13)
);

-- 참조하는 키의 테이블 선언
CREATE table emp_f(
	empno int(4),
    ename varchar(10),
    job varchar(9),
    deptno int(2),
    constraint foreign key(deptno) references dept_p(deptno)
);

INSERT INTO dept_p values(10,'영업부','부여');
INSERT INTO emp_f values(100,'홍길동','clerk',10);

--에러
--기본키 참조중
UPDATE dept_p SET deptno=20 
WHERE deptno=10;

--에러
--기본키 참조중
DELETE FROM dept_p
WHERE deptno=10;

--따라서 외래키 수정을 위해서는
--기본키 수정/추가 후에 외래키 수정해야함
INSERT INTO dept_p values(20,'생산부','부여');
UPDATE emp_f SET deptno=20
WHERE ename = '홍길동';



--check
--컬럼단위 체크제약조건
CREATE table dept_c1(
	deptno int(2) check(deptno>=30),
    dname varchar(14),
    loc varchar(13)
);

INSERT INTO dept_c1 values (40,'개발부','서울');

--check
--테이블단위 체크제약조건
CREATE table dept_c2(
	deptno int(2),
    dname varchar(14),
    loc varchar(13),
    check(deptno>=30)
);

-- 복합키
CREATE table order_u1(
	pcode int(4),
    ccode int(4),
    orderdate date,
    etc varchar(20),
    constraint unique(pcode, ccode)
);


CREATE table order_p1(
	pcode int(4),
    ccode int(4),
    orderdate date,
    etc varchar(20),
    constraint primary key(pcode, ccode)
);


CREATE table dept_n(
	deptno int(2),
    dname varchar(14),
    loc varchar(13)
);

--제약조건 수정
ALTER table dept_n
MODIFY deptno int(2) not null;

--제약조건 수정
ALTER table dept_n
MODIFY deptno int(2);

--unique제약조건 추가
 ALTER table dept_n
ADD constraint unique(deptno);

--unique제약조건 삭제
ALTER table dept_n
DROP index deptno;

--기본키 설정
ALTER table dept_n
ADD constraint primary key(deptno);

--기본키 삭제
ALTER table dept_n
DROP constraint primary key;

CREATE table emp_n(
	empno int(4),
    ename varchar(10),
    job varchar(10),
    deptno int(2)
);

--외래키 설정
ALTER table emp_n
add constraint foreign key(deptno) references dept_n(deptno);




--뷰 생성
CREATE view emp_vu
AS SELECT * from emp;

--뷰인지 확인하는 구문
show full tables;

DROP table dept_n1;
DROP table dept_p1;
DROP table dept_p2;
DROP table dept_u1;
DROP table dept_u2;
DROP table dept_a1;
DROP table dept_p;
DROP table emp_f;
DROP table dept_c1;
DROP table dept_c2;
DROP table order_u1;
DROP table order_p1;
DROP table emp_n;
DROP table dept_n;
DROP table dept_p;

--뷰 생성
CREATE view emp_vu
AS SELECT * from emp;

--뷰인지 확인하는 구문
show full tables;

--뷰는 실제 테이블처럼 쓸 수 있다
SELECT empno, ename, job
FROM emp_vu
WHERE deptno=20;

--원천 데이터를 일부 숨기기 위해서 뷰를 만든다
CREATE view emp_vu_10
AS SELECT empno, ename, mgr, job
FROM emp
WHERE deptno = 10;

--컬럼이름을 다르게 설정할 수 있다
CREATE view emp_vu_20
AS SELECT empno no, ename, mgr, job
FROM emp
WHERE deptno = 10;

--사원번호, 사원이름, 급여, 연봉정보를 조회할 수 있는 emp_sal이라는 view생성
CREATE VIEW emp_sal
AS SELECT empno no, ename name, sal, sal*12+ifnull(comm,0) annsal
FROM emp;

--없으면 뷰 만들고 있으면 뷰 이걸로 대체(replace)
CREATE or REPLACE view emp_sal
AS SELECT empno, ename, job, sal*12+ifnull(comm,0) annsal
from emp;

--사원번호, 사원이름, 담당업무,연봉정보, 호봉을 조회할 수 있는 emp_salgrade이라는 view생성
CREATE view emp_salgrade
AS SELECT empno no, ename name, job, sal*12+ifnull(comm,0) annsal, grade
FROM emp e inner join salgrade s
ON e.sal between s.losal and s.hisal;

--view 스키마 확인
desc information_schema.views;

--view 컬럼과 닉네임 확인
SELECT table_name, view_definition
FROM information_schema.views
WHERE table_schema='sample';

--view중 하나의 view의 컬럼과 닉네임 확인
SELECT table_name, view_definition
FROM information_schema.views
WHERE table_name = 'emp_vu';

--특정 뷰의 생성 확인
show create view emp_vu;

--특정 테이블의 생성 확인
show create table dept;

--옵션 추가
show create view emp_vu \G;

-- 간단한 인라인 뷰 예시
SELECT *
FROM (SELECT *
		FROM emp
        WHERE deptno=20) e;
 
-- 인라인 뷰를 통한 조인
SELECT e.empno, e.ename, d.deptno, d.dname
FROM (SELECT *
		FROM emp
        WHERE deptno IN (10,20)) e INNER JOIN dept d
ON e.deptno = d.deptno;

DROP view emp_vu;
DROP view emp_vu_10;
DROP view emp_vu_20;
DROP view emp_sal;
DROP view emp_salgrade;