-- �������ݿ�����ݱ�
create database guestBookDB
go

use guestBookDB
go

create table guestBook
(
	id int identity(1, 1) primary key,
	title varchar(50) not null,
	userName varchar(20) not null,
	content varchar(1000) not null,
	putTime dateTime default getDate()
)
go

-- ɾ�����ݿ�
-- use master
-- go
-- drop database guestBookDB
-- go