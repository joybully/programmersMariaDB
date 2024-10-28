CREATE table dept1
    AS SELECT *
    FROM sample.dept
    WHERE 1!=1;

desc dept1;

insert into dept1 values(10, '개발부', '서울');
insert into dept1 values(20, '연구부', '부산');

SELECT * FROM dept1;
 
-- 데이터의 파라미터를 넣는 순서를 바꾼다
insert into dept1 (loc, dname, deptno) values('서울', '홍보부', 30);

select * from dept1;

--bulky insert
insert into dept1 values(11,'개발부', '서울'), (12, '개발부', '서울'), (13,'개발부','서울');
select * from dept1;

-- 외부 테이블에서 데이터를 읽어 와서 insert
CREATE table if not exists dept2 like sample.dept;

desc dept2;
SELECT * from dept2;
INSERT into dept2
SELECT * from sample.dept;

SELECT * from dept2;

INSERT into dept1 values(21, '총무부', null);
INSERT into dept1 (deptno, dname) values(21, '총무부');
INSERT into dept1 values(21, '총무부', '');

-- not null 필수 항목
-- 없으면 옵션 항목
CREATE table if not exists dept3(
	deptno int(2) not null,
    dname varchar(14),
    loc varchar(13)
    );

-- 부분행 수정
UPDATE dept1
SET loc='부산'
WHERE deptno=21;

-- 행 삭제
DELETE from dept1
WHERE deptno=21;

CREATE table if not exists emp1
    AS SELECT *
    FROM sample.emp;

UPDATE emp1
    SET deptno = 30
    WHERE sal between 1000 and 2000;

DROP table if exists dept1;
DROP table if exists dept2;
DROP table if exists dept3;
DROP table if exists emp1;
DROP database if exists test1;