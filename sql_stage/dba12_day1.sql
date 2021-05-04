grant create view to movie;

-- view documentation : Database Reference
-- static view
select count(*) from all_tables;
select count(*) from dba_tables;

-- dynamic view
select * from v$session where username = 'MOVIE';

select * from stars where name like 'Bruce Wil%'; -- stars not visible without schema
select * from movie.stars where name like 'Bruce Wil%';

-- create user
create user fan identified by password;
grant connect to fan;

-- synonyms :
-- private synonym for fan only
create synonym fan.movies FOR movie.v_movie_70;
-- public synonym for everyone
create public synonym stars for movie.stars;

