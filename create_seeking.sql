use normalization1;
drop table if exists seeking;

create table seeking (
    seeking_ID int(11) unsigned not null auto_increment,
    seeking varchar(40) not null,
    primary key (seeking_ID)
) as
    select distinct substring_index(seeking, ', ', 1) as seeking
    from my_contacts
    where seeking is not null
    UNION
    select distinct substring_index(seeking, ', ', -1) as seeking
    from my_contacts
    where seeking is not null
    order by seeking;

drop table if exists contacts_seeking;

create table contacts_seeking(
    contact_ID int(11) unsigned,
    seeking_ID int(11) unsigned,
    foreign key (contact_ID) references my_contacts(UID),
    foreign key (seeking_ID) references seeking(seeking_ID)
);

insert into contacts_seeking(contact_ID, seeking_ID)
select mc.UID, s.seeking_ID
from my_contacts mc
    inner join seeking s
        on substring_index(mc.seeking, ', ', 1) = s.seeking
where mc.seeking is not null
union
select my_contacts.UID, s.seeking_ID
from my_contacts
    inner join seeking s
        on substring_index(my_contacts.seeking, ', ', -1) = s.seeking
where my_contacts.seeking is not null
order by UID, seeking_ID;

select mc.last_name, mc.first_name, cs.seeking_ID, s.seeking
from contacts_seeking cs
inner join my_contacts mc on cs.contact_ID = mc.UID
inner join seeking s on cs.seeking_ID = s.seeking_ID
order by mc.UID;

alter table my_contacts
    drop column seeking;