create table t1(
	id int primary key
);

create table t2(
	id int primary key
);

insert into t1 values(1),(2),(3);
insert into t2 values(1),(2),(3),(4),(5),(6);

--합집합
select id from t1
union
select id from t2;

--합집합(겹치는 것들도)
select id from t1
union all
select id from t2;

--교집합
select distinct t1.id
from t1 inner join t2
on t1.id = t2.id;

--차집합
-- t1 빼기 t2
select id
from t1 left join t2
using (id)
where t2.id is null;


--차집합
-- t2 빼기 t1
select id
from t1 right join t2
using (id)
where t1.id is null;

drop table t1;
drop table t2;