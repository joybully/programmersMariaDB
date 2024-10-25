--ROA 복습문제
--1. 데이터베이스의 목록을 확인할 수 있는 SQL 문장을 기술하십시오.
SHOW databases;

--2. 테이블의 목록을 확인할 수 있는 SQL 문장을 기술하십시오.
SHOW tables;

--3. 테이블의 구조를 확인할 수 있는 SQL 문장을 기술하십시오.
DESC dept;
DESC emp;
DESC salgrade;

--4. 사원 테이블에서 사원들의 연봉(SAL*12+comm)을 계산하여, 컬럼명은 "사원 연봉"으로 출력하는 SQL 문장을 기술하십시오.
SELECT empno, ename, sal, (sal*12+ifnull(comm,0)) '사원연봉'
FROM emp;

--5. 사원 테이블을 이용하여 다음과 같은 결과를 얻을 수 있는 SQL 문장을 기술하십시오.
--사원정보
--SMITH의 업무는 CLERK이고 급여는 800만원입니다
--ALLEN의 업무는 SALESMAN이고 급여는 1600만원입니다
--WARD의 업무는 SALESMAN이고 급여는 1250만원입니다
--JONES의 업무는 MANAGER이고 급여는 2975만원입니다
--MARTIN의 업무는 SALESMAN이고 급여는 1250만원입니다
--BLAKE의 업무는 MANAGER이고 급여는 2850만원입니다
--CLARK의 업무는 MANAGER이고 급여는 2450만원입니다
--SCOTT의 업무는 ANALYST이고 급여는 3000만원입니다
--KING의 업무는 PRESIDENT이고 급여는 5000만원입니다
--TURNER의 업무는 SALESMAN이고 급여는 1500만원입니다
--ADAMS의 업무는 CLERK이고 급여는 1100만원입니다
--JAMES의 업무는 CLERK이고 급여는 950만원입니다
--FORD의 업무는 ANALYST이고 급여는 3000만원입니다
--MILLER의 업무는 CLERK이고 급여는 1300만원입니다
SELECT concat(ename,'의 업무는 ',job,'이고 급여는 ',sal,'만원입니다') '사원정보'
FROM emp;

--6. 사원 테이블에서 입사일이 2011년도인 사원의 사원번호, 사원이름, 입사일, 담당업무, 사원급여를 검색하는 SQL 문장을 기술하십시오.
--case1
SELECT empno, ename, hiredate, job, sal
FROM emp
WHERE hiredate like '2011%';
--case2
 SELECT empno, ename, hiredate, job, sal
FROM emp
WHERE hiredate >= '2011-01-01' and hiredate < '2012-01-01';

--7. 사원 테이블에서 입사일이 2011년이고 업무가 'SALESMAN'이 아닌 사원의 사원번호, 사원이름, 입사일, 담당업무, 사원급여를 검색하는 SQL 문장을 기술하십시오.
SELECT empno, ename, hiredate, job, sal
FROM emp
WHERE hiredate >= '2011-01-01' and hiredate < '2012-01-01' and job not like 'SALESMAN';

--8. 사원 테이블의 사원번호, 사원이름, 입사일, 담당업무, 급여를 급여가 높은 순으로 정렬하고, 급여가 같으면 입사일이 빠른 사원으로 정렬하는 SQL 문장을 기술하십시오.
SELECT empno, ename, hiredate, job, sal
FROM emp
ORDER BY sal desc,hiredate;

--9. 사원 테이블에서 사원이름의 세 번째 알파벳이 'N'인 사원의 사원번호, 사원이름을 검색하는 SQL 문장을 기술하십시오.
SELECT empno, ename
FROM emp
WHERE ename like '__N%';

--10. 사원 테이블에서 연봉(SAL*12)이 35000 이상인 사원번호, 사원이름, 사원연봉을 검색하는 SQL 문장을 기술하십시오.
SELECT empno, ename, sal
FROM emp
WHERE (sal*12)>=35000;

--11. 사원 테이블의 사원이름에서 2번째 문자부터 3개의 문자를 추출하여 출력하는 SQL 문장을 기술하십시오.
SELECT substring(ename,2,3)
FROM emp;

--12. 사원 테이블에서 입사일이 12월인 사원의 사원번호, 사원이름, 입사일을 검색하는 SQL 문장을 기술하십시오.
--case1
SELECT empno, ename, hiredate
FROM emp
WHERE hiredate like '_____12%';
--case2
SELECT empno, ename, hiredate
FROM emp
WHERE month(hiredate) like '12';
--case3
SELECT empno, ename, hiredate
FROM emp
WHERE date_format(hiredate,'%m') like '12';
--case4
SELECT empno, ename, hiredate
FROM emp
WHERE monthname(hiredate) like 'december';

--13. 다음과 같은 결과를 출력하는 SQL 문장을 기술하십시오.
--EMPNO ENAME 급여
--7369 SMITH *******800
--7499 ALLEN ******1600
--7521 WARD ******1250
--7934 MILLER ******1300
SELECT concat(empno,' ',ename,' ',lpad(truncate(sal,0),10,'*')) as 'EMPNO ENAME 급여'
FROM emp;

--14 개의 행이 선택되었습니다.
--case1
SELECT count(*) '행 개수'
FROM emp;
--case2
SELECT count(ifnull(comm,0)) '행 개수'
FROM emp;