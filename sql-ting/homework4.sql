--A
select count (*) from songs s
where s.duration > '01:00:00'
--ans 2

--B
--select b.hoursec + b.minsec + b.secsec as seconds from (
--select cast(substring(cast(a.sum as varchar), 1, 4) as int) * 60 * 60 as hoursec,
--cast(substring(cast(a.sum as varchar), 6, 2) as int) * 60 as minsec,
--cast(substring(cast(a.sum as varchar), 9, 2) as int) as secsec
--from (
--select sum(s.duration) from songs s
--) a
--) b

select extract (epoch from (
select sum(s.duration) from songs s
)
)
--ans 3883371

--C
select max(count) from (
select extract (year from s.releasedate) as year, count (*)
from songs s
group by year
) a
--ans 833

--D
select count (*)
from albumartists a
join artists ar on ar.artistid = a.artistid
where ar.artist = 'Tom Waits'
--ans 24

--E
select count (*) from (
select a.albumid from albums a
join albumgenres ag on ag.albumid = a.albumid
join genres g on ag.genreid = g.genreid
where g.genre like 'Alt%'
group by a.albumid
) a
--ans 421

--F
select sum(num) from (
select s.title, count(*) as num from songs s
group by s.title
) a
where a.num > 1
--ans 2072

--G
select (
(select count (*) from (
select count (*) from albumgenres ag
group by ag.albumid, ag.genreid
) a
) * 1.0 /
(select count (*) from 
(select count (*) from albumgenres a
group by a.albumid) as a
) * 1.0
)
--ans 1.1994

--H
select (select count (*) from albums) - (
select count (*) from albums a
join albumgenres ag on ag.albumid = a.albumid
join genres g on g.genreid = ag.genreid
where g.genre = 'Hiphop'
)
--ans 1351
