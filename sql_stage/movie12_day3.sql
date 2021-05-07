select count(*) from movies;
select * from movies where title like 'Alien%';

call addmovies(10, 'Fast and Furiois'); commit;
select * from movies where title like 'Fast%';

select count(*) from play;
drop table play;

alter session set nls_date_format='YYYY-MM-DD';
update stars set birthdate = '1900-12-31' where name='Bruce Willis'; 
commit;

-- after full backup plus archivelog
call addmovies(1000, 'Rambo'); commit;
call addmovies(10000, 'Rocky'); commit;
