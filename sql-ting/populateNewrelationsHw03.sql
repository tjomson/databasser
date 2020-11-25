drop table if exists P;
create table P (
	PID int primary key,
	PN varchar(100)
);
insert into P
select PID,PN
from rentals
on conflict do nothing;

drop table if exists H;
create table H (
	HID int primary key,
	HS varchar(100),
	HZ int
);
insert into H
select HID, HS, HZ
from rentals
on conflict do nothing;

drop table if exists Cities;
create table Cities (
	HZ int primary key,
	HC varchar(100)
);
insert into Cities
select HZ, HC
from rentals
on conflict do nothing;

drop table if exists Rentalss;
create table Rentalss (
	PID int,
	HID int,
	S varchar(100),
	primary key(PID, HID)
);
insert into Rentalss
select PID, HID, S
from rentals;
