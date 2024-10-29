CREATE database if not exists test1;
use test1;
CREATE table if not exists tbl1(
	col1 varchar(2)
    );
CREATE table if not exists tbl2(
	col1 varchar(2)	
	);
-- 다른 데이터베이스를 조회하는 방법 -> 객체처럼 조회한다
desc sample.emp;

-- test1에서 dept 테이블 생성
CREATE table if not exists dept(
	deptno int(2),
    dname varchar(14),
    loc varchar(13)
    );
    
DROP table if exists tbl1;
DROP table if exists tbl2;
DROP table if exists tbl2;


-- 테이블 복제
CREATE table if not exists dept1
	AS SELECT *
    FROM sample.dept;
    
-- 테이블 부분 복제
CREATE table if not exists dept2
	AS SELECT loc, dname
    FROM sample.dept;

-- 테이블 행 제한 후 복제
CREATE table if not exists dept3
	AS SELECT loc, dname
    FROM sample.dept
    WHERE deptno = 10;

-- 사원번호, 사원이름, 급여, 연봉, 입사일자가 복제되어 있는 emp_year1 테이블 생성
CREATE table if not exists emp_year1
	AS SELECT empno, ename, sal, sal*12 + ifnull(comm,0) anusal, hiredate
    FROM sample.emp;

-- 위의 코드에서 컬럼명 지정하기
CREATE table if not exists emp_year2
	AS SELECT empno, ename, sal, sal*12 + ifnull(comm,0) anusal, hiredate as date
    FROM sample.emp;

-- 데이터 복제 안하고 껍데기만 복제
-- where절에서 부정조건을 걸어서(0!=0 이런 것도 가능) 데이터를 못넣게 함
CREATE table if not exists empty
	AS SELECT *
    FROM sample.dept
    WHERE 1!=1;
    
-- 위와 같이 데이터 복제 안하고 껍데기만 복제
CREATE table if not exists empty_dept2
	LIKE sample.dept;


-- 사원번호, 사원이름, 부서번호, 부서이름, 부서위치를 저장할 수 있는 emp_dept 테이블 생성 스크립트
CREATE table if not exists emp_dept
	AS SELECT e.empno, e.ename, d.deptno, d.dname, d.loc
    		FROM sample.emp e inner join sample.dept d
            ON e.deptno = d.deptno
            WHERE 1 !=1;


CREATE table if not exists emp_alter1
	AS SELECT empno, ename, sal, hiredate
    FROM sample.emp
    WHERE 1!=1;
    
-- 새로운 컬럼 추가
ALTER table if exists emp_alter1
	ADD job varchar(9);
    
desc emp_alter1;

-- 컬럼 크기 변경
ALTER table if exists emp_alter1
	MODIFY job varchar(20);
    
desc emp_alter1;

-- 컬럼 이름 변경
ALTER table if exists emp_alter1
	RENAME COLUMN job to work;
    
desc emp_alter1;

-- 컬럼 삭제
ALTER table if exists emp_alter1
	drop work;
    
desc emp_alter1;

-- 테이블 이름 변경
ALTER table emp_alter1
RENAME emp_alter;

drop table if exists dept;
drop table if exists dept1;
drop table if exists dept2;
drop table if exists dept3;
drop table if exists emp_alter1;
drop table if exists emp_dept;
drop table if exists emp_year1;
drop table if exists emp_year2;
drop table if exists empty;
drop table if exists empty_dept2;