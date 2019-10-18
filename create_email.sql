use normalization1;
drop table if exists email;

create table email
(
    email_ID int(11) unsigned not null auto_increment,
    email    varchar(40)      not null,
    primary key (email_ID)
) as
select distinct email
from my_contacts
where email is not null;

drop table if exists contacts_email;

create table contacts_email
(
    contact_ID  int(11) unsigned,
    email_ID int(11) unsigned,
    foreign key (contact_ID) references my_contacts (UID),
    foreign key (email_ID) references email (email_ID)
);

insert into contacts_email(contact_ID, email_ID)
select mc.UID, e.email_ID
from my_contacts mc
         inner join email e
                    on mc.email = e.email
where mc.email is not null
order by UID, email_ID;

select mc.last_name, mc.first_name, mc.email, ce.email_ID, e.email
from contacts_email ce
         inner join my_contacts mc on ce.contact_ID = mc.UID
         inner join email e on ce.email_ID = e.email_ID
order by mc.UID;


alter table my_contacts
    drop column email;