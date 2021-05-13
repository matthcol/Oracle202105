alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
select * from v$log;
select current_scn from v$database;
select * from v$database_incarnation;
select * from dba_data_files;
select * from v$datafile;

-- RMAN --
-- Database Backup and Recovery User's Guide
-- list command
list backup;
list backup of database;
list backup of database summary;
list backup of controlfile;
list backup of spfile;
list expired backup;
list expired backupset;
list backupset 1;
-- report
report obsolete;
show retention policy;
-- delete
delete backupset 4,5,6,7,9,14;


-- parameters
show all;

-- restore/recover one datafile
restore datafile 7;
recover datafile 7;

-- full restore/recover
restore database;
recover database;

-- restore spfile/controfile
restore controlfile from autobackup;
-- if you lost everything:
-- you need any pfile (dbname and memory should be enough)
startup nomount PFILE='/app/oracle/admin/oraLin12/pfile/init.ora.526202012638';
restore spfile from '/app/oracle/recovery_area/ORALIN12/backupset/o1_mf_s_1071843337_j97qh9j4_.bkp';
restore controlfile from '/app/oracle/recovery_area/ORALIN12/backupset/o1_mf_s_1071843337_j97qh9j4_.bkp';

-- crosscheck referentiel vs files present
-- with recovery area set, do a lot of stuff (add/remove)
crosscheck backup;
crosscheck archivelog;
-- look at all logs to decide until restore/recover
select * from v$log;
list archivelog all;  -- archive dest
list backup of archivelog all; -- backup dest
-- after incomplete restore/recover
alter database open resetlogs;
list incarnation;

-- validation
list backup of database;
validate datafile 7;
validate backupset 26;
validate database;
	
-- replay archivelog/redo logs after restore from dump/capture/...
-- sqlplus / as sysdba
startup mount
recover database
    auto -- or play each archivelog at a time