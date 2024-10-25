--직책별 급여 인상
--analyst 10%인상
--clerk 50%인상
--manager 20%인상
--salesman 30%인상
--etc 인상없음
SELECT empno, ename, job, truncate(sal,0) '현재급여',
CASE job
	WHEN 'analyst' THEN truncate(sal*1.1,0)
    WHEN 'clerk' THEN truncate(sal*1.5,0)
    WHEN 'manager' THEN truncate(sal*1.2,0)
    WHEN 'salesman' THEN truncate(sal*1.3,0)
    ELSE truncate(sal,0)
END '인상급여'
FROM emp;