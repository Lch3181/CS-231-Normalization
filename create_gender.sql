USE Normalization1;
DROP TABLE IF EXISTS gender;

CREATE TABLE gender (
  gender_ID int(11) NOT NULL auto_increment,
  gender VARCHAR(25) NOT NULL,
  PRIMARY KEY  (gender_ID)
) AS
	SELECT DISTINCT gender
	FROM my_contacts
	WHERE gender IS NOT NULL
	ORDER BY gender;

ALTER TABLE my_contacts
	ADD COLUMN gender_ID INT(11);

UPDATE my_contacts
	INNER JOIN gender
	ON gender.gender = my_contacts.gender
	SET my_contacts.gender_ID = gender.gender_ID
	WHERE gender.gender IS NOT NULL;

select mc.last_name, mc.first_name, mc.gender, mc.gender_ID, gn.gender
	FROM gender AS gn
		INNER JOIN my_contacts AS mc
	ON gn.gender_ID = mc.gender_ID
order by mc.UID;

ALTER TABLE my_contacts
	DROP COLUMN gender;

