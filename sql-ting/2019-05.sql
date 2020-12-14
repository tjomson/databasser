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




