SELECT ename, sal,
  CASE job
  	WHEN 'analyst' THEN '조사'
      WHEN 'clerk' THEN '사원'
      WHEN 'manager' THEN '관리'
      WHEN 'president' THEN '대표'
      ELSE '영업'
  END '한글명 표시'
  FROM emp
  WHERE deptno = 30;