--1
select count (*) from person p 
where p.height is null;
--ans 47315

--2
select count (*) from (
select m.id from movie m
join involved i on m.id = i.movieid
join person p on i.personid = p.id
group by m.id
having avg(p.height) > 190
) m;
--ans 89

--3
select count (*) from (
select m.id from movie m
join movie_genre mg on mg.movieid = m.id
group by m.id, mg.genre
having count (m.id) > 1
) m;
--ans 174

--fixed version 
select count (distinct m.id) from (
select m.id from movie m
join movie_genre mg on mg.movieid = m.id
group by m.id, mg.genre
having count (m.id) > 1
) m;
--ans 143

--4
select count (distinct v2.personid) from (
select v.movieid as moviesByThatGuy from person p
join involved v on v.personid = p.id
where p.name = 'Steven Spielberg' and v.role = 'director'
) movieWithThatDirector
join involved v2 on v2.movieid = movieWithThatDirector.moviesByThatGuy
where role = 'actor';
--ans 2219

--5
select 
(select count (*) from movie m 
where m.year = 1999) -
(select count (num) from(
select count (*) from involved i
join movie m on i.movieid = m.id
where m.year = 1999
group by m.id
	) as num) moviesWithNoEntries;
--ans 7

--6
select count (*) from (
select p.id from person p
join involved i on p.id = i.personid
join involved i2 on i.personid = i2.personid
where i2.role = 'director' 
and i.role = 'actor'
and i.movieid = i2.movieid
group by p.id
having count (*) > 1
) as selfDirectors;
--ans 345

--7
select count (*) from (
select count(*) from(
select m.id, i.role, count(*)
from movie m
join involved i on i.movieid = m.id
group by m.id, i.role
having m.year = '1999'
) as numberOfRolesForEachMovieFromThatYear
group by id
having count(*) >= (
select count(*) from role
)
) numberOfMoviesWithAllRoles
--ans 250


--8	
select count (*) from (
select a.personid, count(*) from (
select i.personid, g.genre from involved i
join movie m on m.id = i.movieid
join movie_genre mg on mg.movieid = m.id
join genre g on g.genre = mg.genre
group by i.personid, g.genre
having g.category = 'Lame'
order by i.personid
) as a
group by a.personid
having a.count = (
select count (*) from genre g
where g.category = 'Lame'
)
) as b
--ans 1