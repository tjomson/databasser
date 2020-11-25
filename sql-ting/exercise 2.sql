--1
select * from sports  S order by S.name

--2
select s.name
from sports s
join results r on r.sportid = s.id

--3
select count (distinct r.peopleid)
from results r

--4
select p.id, p.name from results r
join people p on p.id = r.peopleid
group by p.id
having count(*) >= 20
order by p.id


--5
select distinct p.id, p.name, g.description from people p
join gender g on g.gender = p.gender
join results r on p.id = r.peopleid
join sports s on r.result = s.record and r.sportid = s.id

--6
select s.name, count(distinct p.id) as numathletes from people p
join results r on p.id = r.peopleid
join sports s on r.result = s.record where r.sportid = s.id
group by s.id

--7
select p.id, p.name, count(p.id) as num, max(r.result) as best, to_char(s.record - max(r.result), '0D99') as diff
from people p
join results r on p.id = r.peopleid
join sports s on s.id = r.sportid
where r.sportid = 2
group by p.id, s.record
having count(p.id) >= 20
order by best desc

--8
select distinct p.id, p.name, g.description from people p
join gender g on g.gender = p.gender
join results r on p.id = r.peopleid
join competitions c on r.competitionid = c.id
where c.place like 'Hvide Sande'
and extract(year from c.held) = 2009

--9
select p.name, g.description
from people p
join gender g on p.gender = g.gender
where p.name like '% J%sen'

--10
select p.name, s.name, to_char(((r.result / s.record)*100), '999%') as percentage
from results r
join people p on p.id = r.peopleid
join sports s on r.sportid = s.id
where r.result is not null
and p.id = 47

--11
select count(distinct r.peopleid)
from results r
where r.peopleid is null
or r.competitionid is null
or r.sportid is null
or r.result is null

--12
select s.id, s.name, max(r.result) as maxres
from sports s
join results r on r.sportid = s.id
group by s.id
order by s.id

--13
select p.id, p.name, count(p.id) as counter
from people p
join results r on p.id = r.peopleid
join sports s on r.sportid = s.id
where s.record = r.result
group by p.id
having count(distinct s.id) >= 2




