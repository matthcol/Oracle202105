select * from stars where id=246; --name = 'Bruce Willis';
-- 246	Bruce Willis	1955-03-03
select current_timestamp from dual; -- SCN: 2567608, TS: 07/05/21 09:28:39,460178000 EUROPE/PARIS

update stars set name='Winnie Willis' where id = 246;
commit;
select * from stars where id=246;
select current_timestamp from dual;  -- 07/05/21 09:32:54,136031000 EUROPE/PARIS

-- flashback query
select * from stars as of SCN 2567608 where id = 246;

select s.id, s.name, s_old.name as old_name 
from 
    stars as of SCN 2567608 s_old
    join stars s on s_old.id = s.id
where s.id = 246;

select * from stars as of TIMESTAMP TO_TIMESTAMP('2021-05-07 09:28','YYYY-MM-DD HH24:MI')
where id = 246; -- 246	Bruce Willis	1955-03-03

select * from stars as of TIMESTAMP TO_TIMESTAMP('2021-01-01 07:00','YYYY-MM-DD HH24:MI')
where id = 246; --  définition de table modifiée

-- flashback versions query
update stars set name='Brenda Willis' where id = 246;
commit;

select 
    versions_startscn, versions_endscn,
    versions_starttime, versions_endtime,
    versions_xid,
    s.* 
from stars VERSIONS BETWEEN TIMESTAMP 
    SYSTIMESTAMP - INTERVAL '30' MINUTE AND
    SYSTIMESTAMP -- - INTERVAL '1' MINUTE
    s
where id = 246;