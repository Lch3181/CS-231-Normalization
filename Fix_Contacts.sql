use normalization1;

#fix database had not primary key
alter table my_contacts add column UID int(11) unsigned primary key not null auto_increment;

#fix San Francisco and San Fran are the same
update my_contacts
set location = 'San Francisco, CA'
where location = 'San Fran, CA';

# fix emails with extra space and newline
update my_contacts
set email = concat(left(email, locate(' \n', email)-1), right(email, locate(' \n', email)+3))
where locate(' \n', email) > 1;
