use normalization1;
drop table if exists interest;

create table interest
(
    interest_ID int(11) unsigned not null auto_increment,
    interest    varchar(40)      not null,
    primary key (interest_ID)
) as
select distinct substring_index(interests, ', ', 1) as interest
from my_contacts
where interests is not null
UNION
select distinct substring_index(substring_index(interests, ', ', 2), ', ', -1) as interest
from my_contacts
where interests is not null
union
select distinct substring_index(interests, ', ', -1) as interest
from my_contacts
where interests is not null
order by interest;

drop table if exists contacts_interest;

create table contacts_interest
(
    contact_ID  int(11) unsigned,
    interest_ID int(11) unsigned,
    foreign key (contact_ID) references my_contacts (UID),
    foreign key (interest_ID) references interest (interest_ID)
);

insert into contacts_interest(contact_ID, interest_ID)
select my_contacts.UID, i.interest_ID
from my_contacts
         inner join interest i
                    on substring_index(interests, ', ', 1) = i.interest
where interests is not null
UNION
select my_contacts.UID, i.interest_ID
from my_contacts
         inner join interest i
                    on substring_index(substring_index(interests, ', ', 2), ', ', -1) = i.interest
where interests is not null
union
select my_contacts.UID, i.interest_ID
from my_contacts
         inner join interest i
                    on substring_index(interests, ', ', -1) = i.interest
order by UID, interest_ID;

select mc.last_name, mc.first_name, mc.interests, ci.interest_ID, i.interest
from contacts_interest ci
         inner join my_contacts mc on ci.contact_ID = mc.UID
         inner join interest i on ci.interest_ID = i.interest_ID
order by mc.UID;


alter table my_contacts
    drop column interests;