show parameters undo  -- spfile/pfile
-- undo_management   string  AUTO     
-- undo_retention    integer 3600 -- secondes    
-- undo_tablespace   string  UNDOTBS1


alter system set undo_retention=3600 scope=both; -- memory/spfile/both
select current_scn from v$database;
-- other possibilities : flashback database

-- files orapwd with passwords of sysda, sysoper, sysbackup users
select * from v$pwfile_users;

-- memory management
-- save spfile as a pfile
create pfile from spfile;
-- if started with pfile to test/correct parameters and want to keep them
create spfile from pfile;
-- actuals parameters
show parameter memory_target
show parameter sga
show sga
-- changing for next reboot
-- passer la DB à Automatic Shared Memory Management (SGA only)
alter system set memory_max_target=0 scope=SPFILE;
alter system set memory_target=0 scope=SPFILE;
alter system set sga_max_size=2500M scope=SPFILE;
alter system set sga_target=2500M scope=SPFILE; 
--
-- next reboot, passer la DB de Automatic Management Memory (FULL)
alter system set memory_max_target=2000M scope=SPFILE;
alter system set memory_target=2000M scope=SPFILE;
alter system set sga_max_size=0 scope=SPFILE; --  picked by oracle (1200M in this case)
alter system set sga_target=0 scope=SPFILE;  -- can't have a value in this mode

-- if you want to tune PGA settings
-- https://oracle-base.com/articles/12c/pga_aggregate_limit_12cR1

-- supervisions de sessions
select * from v$session where username = 'MOVIE';
alter system kill session '261,44532';

-- observations des verrous pendant transactions
select * from v$lock;
-- historique de requetes avec statistiques
select * from v$sql;

-- Bonus: transmissibility privileges
-- system privilege
grant create view to movie with admin option;
-- object privilege
grant select on movie.stars to fan with grant option;