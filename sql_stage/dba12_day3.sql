-- REDO LOG
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select * from v$log;
select * from v$logfile;
select * from v$loghist;

-- add a member (mirror) in a redo log : not executed !!!
-- ALTER DATABASE
-- ADD LOGFILE MEMBER '/tmp/redo03b.log'
-- TO GROUP 3;

ALTER DATABASE
ADD LOGFILE GROUP 4 ('/app/oracle/oradata/oraLin12/redo04.log')
SIZE 4M;
ALTER DATABASE
ADD LOGFILE GROUP 5 ('/app/oracle/oradata/oraLin12/redo05.log')
SIZE 4M;
ALTER DATABASE
ADD LOGFILE GROUP 6 ('/app/oracle/oradata/oraLin12/redo06.log')
SIZE 4M;

select * from v$log;
alter system switch logfile;
ALTER DATABASE DROP LOGFILE GROUP 1;
ALTER DATABASE DROP LOGFILE GROUP 2;
ALTER DATABASE DROP LOGFILE GROUP 3;
