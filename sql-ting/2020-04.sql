--a
select count(*) from employees e
where extract(year from e.birthday) = 1954
--23228

--b
select extract(year from e.birthday) from departments d
join dept_manager dm on d.dept_no = dm.dept_no
join employees e on e.emp_no = dm.emp_no
where d.name = 'Finance'
and dm.to_date is null
--1957

--c
select count(*) from (
	select de.dept_no, count(*) from dept_emp de
	where de.to_date is null
	group by de.dept_no
) a 
where a.count > 50000
--2

--d
select *, de.to_date - de.from_date as time from dept_emp de
where de.emp_no = 429386

--f
select count(*) from (
	select t.title, count(*) from titles t
	join dept_emp de on de.emp_no = t.emp_no
	join departments d on de.dept_no = d.dept_no
	where t.to_date is null
	and d.name = 'Development'
	group by t.title
) a
--7

--g
select count(*) from (
	select * from (
		select a.emp_no, count(*) from  (
			select emp_no, t.title, count(*) from titles t
			where t.title like '%Engineer'
			group by t.emp_no, t.title
		) a
		group by a.emp_no
	) b
	where b.count = (
		select count(distinct t.title) from titles t
		where t.title like '%Engineer'
	) 
) c
--3008

--h







