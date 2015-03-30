DROP TABLE IF EXIST public."User" CASCADE;
DROP TABLE IF EXIST public."Device" CASCADE;
DROP TABLE IF EXIST public."Game" CASCADE;
DROP TABLE IF EXIST public."Log" CASCADE;

create type TypeAccess as enum ('ADMIN', 'USER');
create type TypeActivity as enum ('CONNECTED', 'INSTALLED');

create table public."User"(
'ID_User' serial not null,
'active' bool not null,
'display_name' varchar(30) not null,
'email' varchar (50) not null,
'password' varchar(50) not null,
'role' TypeAccess,
'authentication_tokken' varchar (50) not null,
'creation' timestamptz not null,
'last_modification' datetime,
'company' varchar (30)) without oids;


