--a
select count (*) from airport a
where a.country = 'DE'
--17

--b
select count (distinct ai.airport) from airport ai
join country c on ai.country = c.country
where c.region = 'EU'
and exists (
	select f.dep from flights f
	where f.dep = ai.airport
) and exists (
	select f.arr from flights f
	where f.arr = ai.airport
)
--185

--c
select max(a.running) from (
	select f.end_op - f.start_op as running from flights f
) a
--1572

--d
select count(*) from flights f
join airport ai on ai.airport = f.dep
join country c on c.country = ai.country
join aircraft ac on ac.actype = f.actype
where c.region = 'AS'
and ac.capacity > 300
--185

--e
select max(count) from (
	select ac.ag, count(*) from aircraft ac
	group by ac.ag
) a
--24

--f
select count(*) from (
	select *, a.dep - b.arr as diff  from (
		select ai.airport, count(*) as dep from airport ai
		join flights f on f.dep = ai.airport
		group by ai.airport
	) a
	left join (
		select ai.airport, count(*) as arr from airport ai
		join flights f on f.arr = ai.airport
		group by ai.airport
	) b 
	on a.airport = b.airport
) c 
where diff > 0
or diff is null
--124

--g
select * from flights f
join aircraft ai on ai.actype = f.actype
join airport a1 on a1.airport = f.dep
join airport a2 on a2.airport = f.arr
join country c1 on a1.country = c1.country
join country c2 on a2.country = c2.country
where ai.ag = 'F'
and c1.country <> c2.country
and c1.region = c2.region
--518

--h
select count (*) from (
	select a.al, count(*) from (
		select f.al, f.dep, count(*) from flights f
		join airport ai on f.dep = ai.airport
		where ai.country = 'NL'
		group by f.al, f.dep
	) a
	group by a.al
) b
where b.count = (
	select count(*) from airport ai
	where ai.country = 'NL'
)
--1




