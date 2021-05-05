select count(*) from movies;
select * from movies where title like 'Alien%';

call addmovies(10, 'Fast and Furiois'); commit;