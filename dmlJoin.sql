-- cartesain 조인
SELECT *
FROM emp cross join dept;

-- where이용해서 동등조인
SELECT *
FROM emp inner join dept
WHERE emp.deptno = dept.deptno;

-- where에서 조건까지 붙인 동등조인
SELECT *
FROM emp inner join dept
WHERE emp.deptno = dept.deptno and dept.deptno = 10;

-- on이용해서 동등조인
SELECT *
FROM emp inner join dept
ON emp.deptno = dept.deptno 
WHERE emp.deptno = 10;

-- using이용해서 동등조인
SELECT *
FROM emp inner join dept
USING (deptno)
WHERE emp.deptno = 10;

-- 컬럼명 출력-테이블 이름 적어야함
SELECT dept.deptno, dept.dname, emp.empno, emp.ename
FROM emp inner join dept 
ON emp.deptno = dept.deptno
WHERE emp.deptno = 10;

-- alliasing(별명)
SELECT d.deptno, d.dname, e.empno, e.ename
FROM emp e inner join dept d
ON e.deptno = d.deptno
WHERE e.deptno = 10;

-- 담당업무가 clerk인 사원에 대한 
-- 사원번호, 사원이름, 관리자, 부서번호, 부서이름, 부서위치 출력
SELECT e.empno, e.ename, e.mgr, d.deptno, d.dname, d.loc
FROM emp e inner join dept d
ON e.deptno = d.deptno
WHERE e.job = 'clerk';

-- cartesian product
SELECT *
FROM emp cross join salgrade;

-- non-equi join
SELECT *
FROM emp inner join salgrade
WHERE emp.sal >= salgrade.losal and emp.sal <= salgrade.hisal;

-- 열 선택
-- alliasing
-- case1 부등호이용
SELECT e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
FROM emp e inner join salgrade s
WHERE e.sal>=s.losal and e.sal<=s.hisal;
-- case2 between이용
SELECT e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
FROM emp e inner join salgrade s
WHERE e.sal between s.losal and s.hisal;
-- case3 on 이용
SELECT e.empno, e.ename, e.sal, s.grade, s.losal, s.hisal
FROM emp e inner join salgrade s
ON e.sal between s.losal and s.hisal
WHERE e.deptno = 10;

-- 입사년도가 2011년인 사원에 대한 사원번호, 사원이름, 급여, 급여등급(호봉)을 출력
SELECT e.empno, e.ename, e.sal, s.grade
FROM emp e inner join salgrade s
ON e.sal between s.losal and s.hisal
WHERE e.hiredate like '2011%';

-- 사원에 대한 사원번호, 사원이름, 급여등급, 기존급여, 인상급여를 출력
-- 1호봉 -> 40%인상
-- 2호봉 -> 30%인상
-- 3호봉 -> 20%인상
-- 기타 -> 인상없음
SELECT e.empno, e.ename, s.grade, e.sal '기존급여', 
CASE s.grade
	WHEN 1 THEN e.sal*1.4
	WHEN 2 THEN e.sal*1.3
	WHEN 3 THEN e.sal*1.2
	ELSE e.sal
	END '인상급여'
FROM emp e inner join salgrade s
ON e.sal between s.losal and s.hisal;

-- 사원번호, 사원이름, 급여, 부서이름, 부서위치, 호봉을 출력
-- case1
-- 조인하고 조인
SELECT e.empno, e.ename, e.sal, d.dname, d.loc, s.grade
FROM emp e inner join dept d
ON (e.deptno = d.deptno)
inner join salgrade s
ON e.sal between s.losal and s.hisal;
-- case2
-- 한번에 다 조인
SELECT e.empno, e.ename, e.sal, d.dname, d.loc, s.grade
FROM emp e inner join dept d inner join salgrade s
ON e.deptno = d.deptno and e.sal between s.losal and s.hisal;

-- dept를 중심으로, emp를 붙인다, 다시말해 dept데이터는 모두 출력
-- case1
SELECT d.deptno, d.dname, e.empno, e.ename
FROM emp e right outer join dept d
ON d.deptno = e.deptno;
-- case2
SELECT d.deptno, d.dname, e.empno, e.ename
FROM dept d left outer join emp e
ON d.deptno = e.deptno;

-- 사원이 없는 부서
SELECT d.deptno, d.dname, e.empno, e.ename
FROM emp e right outer join dept d
ON d.deptno = e.deptno
WHERE e.ename is NULL;

-- self join
-- 한 개의 테이블 내의 조인
SELECT e.empno, e.ename '사원 이름', e.mgr, m.ename'관리자 이름'
FROM emp e inner join emp m
ON e.mgr = m.empno;


-- 매니저 없는 King도 출력
SELECT e.empno, e.ename '사원', ifnull(e.mgr, '관리자없음') 'mgr number', ifnull(m.ename, '관리자 없음') '관리자'
FROM emp e left outer join emp m
ON e.mgr = m.empno;