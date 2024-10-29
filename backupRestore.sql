--데이터베이스 단위 백업
--mysqldump이용
mysqldump -u root -p sample > sample.sql

--테이블 단위 백업
--sample 데이터베이스의 emp테이블 복사
mysqldump -u root -p sample emp > emp.sql

--데이터베이스 단위 복원
--sample데이터베이스 복원
mysql -u root -p sample < sample.sql

--테이블 단위 복원
--sample 데이터베이스의 emp테이블 복원
mysql -u root -p sample < emp.sql