SELECT empno, ename, deptno, sal '현재급여',
CASE deptno
	WHEN 10 THEN sal*1.1
  	WHEN 20 THEN sal*1.2
  	WHEN 30 THEN sal
  	ELSE sal
END '인상급여'
FROM emp;