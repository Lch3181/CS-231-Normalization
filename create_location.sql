use normalization1;
drop table if exists city;

create table city (
    city_ID int(11) not null auto_increment,
    city varchar(40) not null,
    primary key (city_ID)
) as
    select distinct substring_index(location, ',', 1) as city
    from my_contacts
    where substring_index(location, ',', 1) is not null
    order by substring_index(location, ',', 1);

alter table my_contacts
    add column city_ID int(11);

UPDATE my_contacts
    inner join city
    on city.city = substring_index(my_contacts.location, ',', 1)
    set my_contacts.city_ID = city.city_ID
    where city.city is not null;

drop table if exists state;

create table state (
    state_ID int(11) not null auto_increment,
    state varchar(40) not null,
    primary key (state_ID)
) as
    select distinct substring_index(location, ',', -1) as state
    from my_contacts
    where substring_index(location, ',', -1) is not null
    order by substring_index(location, ',', -1);

alter table my_contacts
    add column state_ID int(11);

UPDATE my_contacts
    inner join state
    on state.state = substring_index(my_contacts.location, ',', -1)
    set my_contacts.state_ID = state.state_ID
    where state.state is not null;


select mc.last_name, mc.first_name, mc.location, mc.city_ID, c.city, mc.state_ID, s.state
    from city as c
        inner join my_contacts as  mc
    on c.city_ID = mc.city_ID
        inner join state s on mc.state_ID = s.state_ID
order by mc.UID;

alter table my_contacts
   drop column location;