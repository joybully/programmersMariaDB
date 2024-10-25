SELECT empno, ename, deptno,
  CASE deptno
  	WHEN 10 THEN '회계'
   	WHEN 20 THEN '조사'
    	WHEN 30 THEN '영업'
    	WHEN 40 THEN '총무'
  	ELSE '없음'
  END '한글명 표시'
  FROM emp;