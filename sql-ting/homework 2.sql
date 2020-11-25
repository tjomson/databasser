--for exercise 1:
--A, B, F, J

--a
select count(*) from empires e
where e.empire = 'Danish Empire'
--ans 3

--b
select count(*) from countries_continents cc
where cc.percentage < 100 and cc.continent = 'Europe'
--ans 2

--c
select SUM((cl.percentage/100) * c.population) from countries_languages cl
join countries_continents cc on cc.countrycode = cl.countrycode
join countries c on c.code = cc.countrycode
where cc.continent = 'South America'
and cl.language = 'Spanish'
and c.population > 1000000
--ans 160,575,157

--d
select count (*) from (
select cl.language from empires e
join countries_languages cl on e.countrycode = cl.countrycode
where e.empire = 'Benelux'
group by cl.language
having count(cl.language) =
(select count(*) from empires e
where e.empire = 'Benelux')
) as numberOfLanguages
--ans 2