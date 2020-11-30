--A
select count (distinct r.toid) from relationships r
--ans 287

--B
select count (*) from (
select * from relationships r
join relationships r2 on r2.toid = r.fromid and r2.fromid = r.toid
where r.fromid > r2.fromid
) a
--ans 46

--C
select 
	(select count (*) from relationships)
	-
	(select count (*) from (
	select r.fromid, r.toid, count(*) from relationships r
	join roles ro on ro.toid = r.toid and ro.fromid = r.fromid
	group by r.fromid, r.toid
	) a)
as diff
--ans 10

--D
drop view if exists commentCount;
create view commentCount as
select c.postid, count(*) as num from comments c
group by c.postid;

select c.postid from commentCount c
where c.num = (select max(num) from commentCount
			   )
--ans 1223

--E
select count (*) from (
select c.postid from commentCount c
where c.num <= 2
union
select p.id from posts p
left join commentCount c on c.postid = p.id
where c.num is null
) a
--ans 1674

--F

--G
select * from (
select a.fromid, count(*) from (
select r.fromid, r.role, count(*) from roles r
group by r.fromid, r.role
order by r.fromid
) a
group by a.fromid
) b
where b.count = 3


--H
select count(*) from (
select * from (
select p.id, count(*) from posts p
join likes l on l.postid = p.id
group by p.id
) a
join (
select p.posterid, count(*) from posts p
left join comments c on p.id = c.postid
where c.text is null
group by p.posterid
) b on a.id = b.posterid
) c
--ans 73
