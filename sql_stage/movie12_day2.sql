-- need quota on tablespace
create index idx_stars_name on stars(name) TABLESPACE IDX_STARS;

select * from stars where name = 'Bruce Willis';
select * from stars where id = 246;

-- BLOB
alter table movies add (teaser blob);

-- test database open read only
delete from play;
select count(*) from play;
insert into movies (title, year) values ('Nobody',2021);
select * from movies where title = 'Nobody';
commit; -- rollback 

