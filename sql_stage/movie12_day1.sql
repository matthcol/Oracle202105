-- DDL : create view
create or replace view v_movie_70 as 
select * from movies 
where year between 1970 and 1979;

-- exploitation
select * from stars where name like 'Bruce Wil%';
select count(*) from v_movie_70;

-- synonyms
select * from user_tables;
select * from all_tables;
select count(*) from all_tables;
select count(*) from dba_tables;
select * from user_views; -- ie. PUBLIC.user_views synonym to view sys.user_views

-- privileges for other users
grant select on stars to fan;
grant select on v_movie_70 to fan;

revoke select on stars from fan;

-- 
alter session set nls_date_format = 'YYYY-MM-DD';
select user from dual;
select sysdate from dual;
select current_date, current_timestamp from dual;

update stars set birthdate = '1955-03-19' where name = 'Bruce Willis';
select * from stars where name = 'Bruce Willis';
alter session set nls_date_format = 'DD/MM/YYYY HH24:MI:SS';
select * from stars where name = 'Bruce Willis';
select sysdate from dual;
select trunc(sysdate) from dual;

mañana > mano