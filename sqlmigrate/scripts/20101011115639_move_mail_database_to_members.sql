--// move mail database to members
-- Migration SQL that makes the change goes here.

alter table mail.folders rename members.messageFolders;
alter table mail.messages rename members.messages;
drop database mail;

--//@UNDO
-- SQL to undo the change goes here.
create database mail;
alter table members.messageFolders rename mail.folders;
alter table members.messages rename mail.messages;


