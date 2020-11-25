--1
drop view if exists AllAccountRecords;
create view AllAccountRecords as
select a.pid, a.adate, a.abalance, a.aover, ar.rid, ar.rdate, ar.rtype, ar.ramount, ar.rbalance
from accounts a
left outer join accountrecords ar on a.aid = ar.aid;

select * from AllAccountRecords

--2
drop trigger if exists checkbills on bills;
drop function if exists checkbills;
create function CheckBills() returns trigger as
$$
begin
	if (tg_op = 'DELETE') then
		raise exception 'you cannot delete';
	end if;
	if (new.bamount < 0) then
		raise exception 'negative amount not allowed';
	end if;
	if (new.bduedate < current_date) then
		raise exception 'date cannot be in the past';
	end if;
	
	return new;
end
$$
language 'plpgsql'

drop trigger if exists checkbills on bills;
create trigger CheckBills
before insert or delete
--of bid, pid, bduedate, bamount
on bills
for each row execute procedure CheckBills();

insert into bills (bid, pid, bduedate, bamount, bispaid)
values(11111, 23, '2029-1-1', -4, 'true')

delete from bills where bid = 2

--3


