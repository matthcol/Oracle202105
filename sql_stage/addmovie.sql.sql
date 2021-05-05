CREATE OR REPLACE procedure addmovies(
	pcount number,
	ptitle varchar, 
	pyearmin number DEFAULT 1888,
	pyearmax integer DEFAULT 3000) 
as 
	vyearoffset number;
	vyeardelta number;
BEGIN
	vyeardelta := pyearmin - pyearmax;
	vyearoffset := 0;
	FOR i IN 1 .. pcount LOOP
		vyearoffset := mod((vyearoffset + 1), vyeardelta);
		insert into movies (title, year) values (ptitle || '_' || i, pyearmin + vyearoffset);
	END LOOP;
END;
/

-- call addmovies(100, 'Alien');
-- select * from movies where title like 'Alien%';