create sequence sys_user$seq 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;

create sequence sys_role$seq 
minvalue 1 
maxvalue 999999999999999999999999999 
start with 1 
increment by 1 
nocache;


create table Sys_Role (
        roleid number(19,0) not null,
        memo varchar2(255),
        name varchar2(255),
        primary key (roleid)
    );

create table Sys_User (
        userid number(19,0) not null,
        department varchar2(255),
        email varchar2(255),
        manager varchar2(255),
        mobile varchar2(255),
        password varchar2(255),
        realname varchar2(255),
        username varchar2(255),
        primary key (userid)
    );
create table sys_r_user_role (
        userid number(19,0) not null,
        roleid number(19,0) not null,
        primary key (userid, roleid)
    );


alter table sys_r_user_role 
        add constraint FK_iljv97wdhg3b7nf8jhhycdg4c 
        foreign key (roleid) 
        references Sys_Role;
alter table sys_r_user_role 
        add constraint FK_axxnnhba897yuqdb44jwhuopb 
        foreign key (userid) 
        references Sys_User;

