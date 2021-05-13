-- connection roles : sysdba, sysoper, sysbackup
select * from v$pwfile_users;

create user operateur identified by password;
grant sysoper to operateur; -- à donner avec session as sysdba

----------------------------------------------------------------
-- change the database in mode archivelog
select log_mode from v$database;
select * from v$log;

-- if you don't want recovery area anymore
show parameter db_reco
-- db_recovery_file_dest      string      /app/oracle/recovery_area 
-- db_recovery_file_dest_size big integer 8256M 
alter system set db_recovery_file_dest='' scope=both;

-- if no recovery area set you have to choose a path for:
-- secondary control file
-- archivelog destination
-- rman backups in rman scripts

-- control file paths
show parameter control
-- control_files   string  /app/oracle/oradata/ORALIN19/control01.ctl, /app/oracle/recovery_area/ORALIN19/control02.ctl 
alter system 
    set control_files='/app/oracle/oradata/ORALIN19/control01.ctl','/app/oracle/mirror/ORALIN19/control02.ctl'
    scope=SPFILE;
    
-- archivelog destination
show parameters log_archi
-- log_archive_dest, log_archive_dest_1, .. log_archive_dest_31
alter system set log_archive_dest='/archivelog' scope=SPFILE;

-- after reboot en mode mount
alter database archivelog; -- puis open
-- force one rotaion of archivelogs
alter system switch logfile;

-- RMAN backup script: backup_database.rman
CONFIGURE RETENTION POLICY TO REDUNDANCY 1;
configure channel device type disk format '/backup/ORALIN19/database-%T-%u.bckp';
CONFIGURE CONTROLFILE AUTOBACKUP ON;
CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK
    TO '/backup/ORALIN19/controlspfile-%T-%F.bck';
run {
    backup database;
    backup archivelog all
        FORMAT '/backup/ORALIN19/archivelog-%T-%u.bck'
        delete all input;
    delete noprompt obsolete;
}


-- rman commands of today
catalog start with '/backup/ORALIN19/'
crosscheck backup; -- after manual rm on disk
list expired backup;
delete expired backup;
list expired backup;

restore spfile from '/backup/ORALIN19/controlspfile-20210507-c-3699418345-20210507-08.bck';

-- Database Administrator’s Guide Chap6
show parameter sga
show parameter memory_target
show sga
-- sga_max_size                 big integer 1520M   
-- sga_min_size                 big integer 0       
-- sga_target                   big integer 0 
-- => automatic memory management => 2G
-- Si > 2G : sga_target à fixer pour la mémoire partagée
--  Automatic Shared Memory Management

-- passer la DB de Automatic Manangement Memory (FULL)
-- à Automatic Shared Memory Management (only SGA)
alter system set memory_max_target=0 scope=SPFILE;
alter system set memory_target=0 scope=SPFILE; 
alter system set sga_max_size=2500M scope=SPFILE;
alter system set sga_target=2500M scope=SPFILE; 

-- passer la DB de Automatic Shared Memory Management (only SGA)
-- à Automatic Manangement Memory (FULL)
alter system set memory_max_target=2000M scope=SPFILE;
alter system set memory_target=2000M scope=SPFILE;
alter system set sga_max_size=0 scope=SPFILE; --  picked by oracle (1200M in this case)
alter system set sga_target=0 scope=SPFILE;  -- can't have a value in this mode 
