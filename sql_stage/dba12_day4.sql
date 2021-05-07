alter session set NLS_DATE_FORMAT='YYYY-MM-DD HH24:MI:SS';
select * from v$log;
select current_scn from v$database;
select * from v$database_incarnation;
select * from dba_data_files;
select * from v$datafile;

-- rman
    -- TO COMPLETE
-- sqlplus / as sysdba
startup mount
recover database
    auto -- or play each archivelog at a time