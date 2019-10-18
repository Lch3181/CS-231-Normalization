use normalization1;

alter table my_contacts add column UID int(11) unsigned primary key not null auto_increment;

update my_contacts
set location = 'San Francisco, CA'
where location = 'San Fran, CA';