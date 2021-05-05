select * from database_properties;

CREATE TABLESPACE IDX_STARS 
    DATAFILE 
        '/app/oracle/oradata/oraLin12/DX_STARS01.DBF' 
    SIZE 2147483648 
    AUTOEXTEND ON NEXT 524288000 
    MAXSIZE UNLIMITED;
    
ALTER DATABASE 
DATAFILE '/app/oracle/oradata/oraLin12/DX_STARS01.DBF' 
AUTOEXTEND ON NEXT 1073741824;

alter user movie quota unlimited on idx_stars;

-- views on tablespaces, data_files
select * from dba_tablespaces;
select * from dba_data_files;
select * from dba_temp_files;

alter tablespace IDX_STARS OFFLINE;
alter tablespace IDX_STARS ONLINE;

ALTER TABLESPACE IDX_STARS
    ADD DATAFILE '/app/oracle/oradata/oraLin12/DX_STARS02.DBF'
    SIZE 2G
    AUTOEXTEND ON NEXT 1G MAXSIZE UNLIMITED;

-- segments : table, index, lob
select * from dba_segments where owner = 'MOVIE';

-- init parameters
show parameters
show parameters contr
-- parameter name: control_files
-- value: /app/oracle/oradata/oraLin12/control01.ctl, /app/oracle/recovery_area/oraLin12/control02.ctl
show parameters sga
show parameters reco
-- db_recovery_file_dest         string      /app/oracle/recovery_area 
-- db_recovery_file_dest_size    big integer 8016M 

alter system set db_recovery_file_dest_size=10G scope=memory; 
alter system set db_recovery_file_dest_size=21G scope=both; -- mem + spfile

alter system 
set control_files='/app/oracle/oradata/oraLin12/control01.ctl','/app/oracle/recovery_area/oraLin12/control/control02.ctl'
scope=spfile;

-- in session as sysdba, create pfile initoraLin12.ora from spfile spfileoraLin12.ora
create pfile from spfile;
-- startup : look for 1. spfile 2. pfile
-- startup nomount pfile='/app/oracle/product/12.2.0/dbhome_1/dbs/initoraLin12.ora';

-- REDO LOG
alter session set nls_date_format='YYYY-MM-DD HH24:MI:SS';
select * from v$log;
select * from v$logfile;
select * from v$loghist;

alter system switch logfile;