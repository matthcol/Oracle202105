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

-- IMPORT JOBS

drop user movie cascade;
select * from dba_users where username like 'MOV%';
impdp system/password PARFILE=imp_movie.par

-- after drop table play :
impdp system/password TABLES=movie.play DUMPFILE=dp_movie.dump LOGFILE=imp_table_play.log
-- again overwriting table play
impdp system/password TABLES=movie.play DUMPFILE=dp_movie.dump LOGFILE=imp_table_play.log TABLE_EXISTS_ACTION=REPLACE

drop user movietmp;
create user movietmp identified by password quota unlimited on users;
grant connect, resource to movietmp;

impdp system/password DUMPFILE=dp_movie.dump LOGFILE=imp_table_play.log  \
    SCHEMAS=movie INCLUDE=table:\"=\'STARS\'\" REMAP_SCHEMA=movie:movietmp    

select * from movietmp.stars where name = 'Bruce Willis';
select count(*) from movietmp.movies;
alter session set nls_date_format='YYYY-MM-DD';
update movie.stars set birthdate = '1955-03-19' where name='Bruce Willis'; 
commit;
drop user movietmp cascade;

-- intro rman : connection cible db ? sauvegarder/restaurer
rman
    connect target /
rman target /
rman target sys/password
-- list : consulter le r?f?rentiel rman
list backup;
list backup of database;
list backup of archivelog all;
list backup of spfile;
list backup of controlfile;
list archivelog all;
list backup summary;
-- backup
backup database; -- backup complet database
backup database plus archivelog;  -- database plus archivelog (ne purge pas le dossier des archivelogs)
backup database plus archivelog delete all input; -- idem et purge dossier archivelog
backup archivelog all delete all input; -- archivelogs uniquement, avec purge

