select count(*) from movies where title like 'Rocky%';

-- movies for restore/recover database with all .dbf lost
call addmovies(10000, 'Harry Potter');
commit;
select count(*) from movies where title like 'Harry Potter%';

-- movies for restore/recover database with ORADATA dir lost
call addmovies(10000, 'Bambi');  
commit;
select count(*) from movies where title like 'Bambi%';

-- incarnation #3 seq 18
call addmovies(50000, 'Evil Dead');  
commit; -- => seq 33
select count(*) from movies where title like 'Evil Dead%';

-- incarnation #4 seq 3
call addmovies(50000, 'Evil Dead');  -- again : ils etaient perdus !
commit; -- => seq 18 (redo6)
select count(*) from movies where title like 'Evil Dead%'; -- 50 001
