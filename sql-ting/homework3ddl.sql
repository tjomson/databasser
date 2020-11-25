drop table if exists people;
create table people (
	ID integer primary key,
	Name varchar(100),
	Address varchar(100),
	phone varchar(8),
	DOB varchar(8),
	DOD varchar(8)
);

drop table if exists members;
create table members (
	ID integer primary key references people(ID),
	Start_date varchar(8) not null
);

drop table if exists enemy;
create table enemy (
	ID integer primary key references people(ID)
);

drop table if exists opposes;
create table opposes (
	MemberID integer references members(ID),
	EnemyID integer references enemy(ID),
	Start_date varchar(8) not null,
	End_date varchar(8) not null
);

create table monitors (
	MemberID integer references members(ID),
	PartyID integer references party(ID),
	primary key (MemberID, PartyID)
);

drop table if exists linking;
create table linking (
	ID integer primary key,
	Name varchar(100),
	Type varchar(100),
	Description varchar(100)
);

drop table if exists participate;
create table participate (
	PersonID integer not null,
	LinkingID integer not null,
	foreign key (PersonID) references people(ID),
	foreign key (LinkingID) references linking(ID),
	primary key (PersonId, LinkingID)
);

drop table if exists party;
create table party (
	ID integer primary key,
	Country varchar(100),
	Name varchar(100)
);

create table roles (
	ID integer primary key,
	Title varchar(100) not null
);

create table serve_in (
	MemberID integer references members(ID),
	RoleID integer references roles(ID),
	Start_date varchar(8) not null,
	End_date varchar(8) not null,
	Salary integer not null,
	primary key (MemberID, RoleID)
);

create table sponsor (
	ID integer primary key,
	Name varchar(100) not null,
	Address varchar(100) not null,
	Industry varchar(100) not null
);

drop table if exists asset;
create table asset (
	Name varchar(100) primary key,
	MemberID integer,
	Details varchar(100) not null,
	Uses varchar(100) not null,
	foreign key (MemberID) references members(ID)
);

create table grants (
	Date varchar(8) primary key,
	Amount integer not null,
	Payback varchar(100) not null,
	MemberID integer,
	SponsorID integer,
	foreign key (MemberID) references members(ID),
	foreign key (SponsorID) references sponsor(ID)
);

create table reviews (
	MemberID integer references members(ID),
	GrantDate varchar(8) references grants(Date),
	primary key (MemberID, GrantDate),
	Date varchar(8) not null,
	Grade integer not null
);

