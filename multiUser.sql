-- 사용자와 권한 출력
desc mysql.user;

-- 특정 사용자와 암호만 출력
SELECT host, user, password
FROM mysql.user;

-- 사용자 등록
-- root사용자가 만든다
-- 로컬 접속만 허용
-- tester1은 사용자 이름
-- ip domain은 localhost
-- 암호는 1234
CREATE user tester1@localhost identified by '1234';

-- 사용자 등록
-- root사용자가 만든다
-- 다른 아이피도 뚫는다 -> 원격접속 허용
CREATE user tester1@'%' identified by '1234';

-- 사용자 삭제
DROP user tester1@localhost;
DROP user tester1@'%';

-- 권한 보기
show privileges;

-- 로컬 호스트 root에게 부여된 권한보기
-- 권한 많이 부여 됨(x아마도 거의 다?)
show grants for root@localhost;

-- test유저 생성
-- test권한 확인
CREATE user tester1@'%' identified by '1234';
show grants for tester1@'%';

-- root가 database 생성 
CREATE database tester1;

-- root가 tester1에게 권한줌
-- tester1에 대한 모든 create권한을 tester1@'%'에게 준다
GRANT CREATE ON tester1.* to tester1@'%';

-- root가 tester2에 emp 테이블 복사
CREATE table tester2.emp
AS SELECT *
FROM sample.emp;

-- root가 tester2에 emp태이블에 대한 select권한 부여
GRANT SELECT ON tester2.emp to tester2@'%';


-- root가 tester2에 emp태이블에 대한 insert권한 부여
GRANT INSERT ON tester2.emp to tester2@'%';

-- root가 tester2에게 tester2의 데이터베이스에 대한 모든 권한을 부여
GRANT all privileges on tester2.* to tester2@'%';

-- 관리자가 tester3db데이터베이스 생성하고 tester3사용자에게 tester3db에 대한 모든 권한을 부여함
-- 이것에 대한 처리를 두줄로 모두 처리
CREATE database tester3db;
GRANT all privileges on tester3db.* to tester3@'%' identified by '1234';