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
--where de.to_date is not null
where not exists (
	select * from dept_emp
	where de.to_date is null
)
group by emp_no


select * from dept_emp
where de.to_date is null
--??????????

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
drop view if exists salaryEmp;
create view salaryEmp as
select t.emp_no, t.title, t.from_date as tFromDate, t.to_date as tToDate, de.dept_no, de.from_date as dFromDate, de.to_date as dToDate, d.name, s.salary, s.from_date as sFromDate, s.to_date as sToDate
from titles t
join dept_emp de on de.emp_no = t.emp_no
join departments d on d.dept_no = de.dept_no
join salaries s on s.emp_no = t.emp_no
where d.name = 'Development'
and s.to_date is null
and t.title = 'Senior Engineer';

select(emp_no) from salaryEmp se
where se.salary = (
	select max(salary) from salaryEmp s
)
--86631




