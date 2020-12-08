--A
select count(*) from places p
where p.name like '%lev'
--12

--B
select p.id from places p
where p.population = (
select max(p.population) from places p
)
--34

--C
select count(*) from (
	select td.teamid, count(*) from teamsindivisions td
	group by td.teamid
) a
where a.count > 1
--62

--D
select count(distinct a.teamid) from (
	select * from teamsindivisions td 
	join teams t on td.teamid = t.id
	join divisions d on td.divisionid = d.id
	where t.genderid <> d.genderid
) a
--54

--E
create or replace view placeCount as
select c.placeid, count(*) from clubs c
join teams t on t.clubid = c.id
join genders g on g.id = t.genderid
where g.gender = 'M'
group by c.placeid

select p.placeid from placecount p
where p.count = (select max(count) from placecount)
--34






