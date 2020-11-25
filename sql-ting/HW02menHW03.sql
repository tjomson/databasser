--1
select count(*) from (
select * from cities c
join countries co on co.code = c.countrycode
where (c.population * 1.0) / (co.population * 1.0) > 0.5
) m
--ans 14

--2
select count(*) from (
select sum(cl.percentage) from countries c
join countries_languages cl on cl.countrycode = c.code
group by c.code
)m
where m.sum < 100
--ans 202

--3
select ci.id from (
	select a.countrycode, (a.max * 1.0) / (b.min * 1.0) as ratio from 
	(select c.countrycode, max(c.population)
		from cities c
		group by c.countrycode
	)a
	join (
		select c.countrycode, min(c.population) from cities c
		group by c.countrycode
	)b on a.countrycode = b.countrycode
	order by ratio desc
	limit 1
) d
join cities ci on d.countrycode = ci.countrycode
order by ci.population desc
limit 1
--ans 456

--4
select c.countrycode from (
	select *, b.sum*1.0 / b.population*1.0 as ratio from (
		select * from (
			select ci.countrycode, sum(ci.population) from cities ci
			group by ci.countrycode
		) a
		join countries co on co.code = a.countrycode
		where co.population > 1000000
	) b
	order by ratio desc
	limit 1
) c
--ans SGP
