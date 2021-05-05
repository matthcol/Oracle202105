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


select * from v$archived_log;
select * from v$database; -- log_mode
-- where are my archive logs ?
show parameters archi
show parameters db_rec
-- db_recovery_file_dest 
-- log_archive_dest
-- log_archive_dest_1 .. 31

desc v$archived_log;
select sequence#, FIRST_CHANGE#, NEXT_CHANGE#  from v$archived_log;
select status, sequence#, FIRST_CHANGE#, NEXT_CHANGE# from v$log;
select * from v$log;
select current_scn from v$database;

-- data pump : default directory DATA_PUMP_DIR
select * from dba_directories where directory_name like 'DATA_P%';

-- documentation : Database Utilities => Data Pump
-- command line
expdp -help
impdp -help
expdp system/password FULL=YES DUMPFILE=dp_full.dump LOGFILE=dp_full.log
expdp system/password PARFILE=dp_movie.par

-- reprendre la main sur job existant
expdp system/password ATTACH=JOB_DP_MOVIE
    help
    status
    CONTINUE_CLIENT
    KILL_JOB (STOP_JOB)

-- supervision des jobs
-- param KEEP_MASTER=yes to keep job master table after completion
select * from dba_datapump_jobs;

drop table SYSTEM."EXP_TABLE_MOVIES-10_47_16";
select * from dba_tables where TABLE_NAME like '%MOVIE%';


