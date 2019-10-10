use normalization1;
drop table if exists profession;

create table profession (
    profession_ID int(11) not null auto_increment,
    profession varchar(25) not null,
    primary key (profession_ID)
) as
    select distinct profession
    from my_contacts
    where profession is not null
    order by profession;

alter table my_contacts
    add column profession_ID int(11);

UPDATE my_contacts
    inner join profession
    on profession.profession = my_contacts.profession
    set my_contacts.profession_ID = profession.profession_ID
    where profession.profession is not null;

select mc.last_name, mc.first_name, mc.profession, mc.profession_ID, p.profession
    from profession as p
        inner  join my_contacts as  mc
    on p.profession_ID = mc.profession_ID
order by mc.UID;

alter table my_contacts
   drop column profession;