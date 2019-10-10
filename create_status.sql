USE Normalization1;
DROP TABLE IF EXISTS status;

CREATE TABLE status (
  status_ID int(11) NOT NULL auto_increment,
  status VARCHAR(25) NOT NULL,
  PRIMARY KEY  (status_ID)
) AS
	SELECT DISTINCT status
	FROM my_contacts
	WHERE status IS NOT NULL
	ORDER BY status;

ALTER TABLE my_contacts
	ADD COLUMN status_ID INT(11);

UPDATE my_contacts
	INNER JOIN status
	ON status.status = my_contacts.status
	SET my_contacts.status_ID = status.status_ID
	WHERE status.status IS NOT NULL;

select mc.last_name, mc.first_name, mc.status, mc.status_ID, gn.status
	FROM status AS gn
		INNER JOIN my_contacts AS mc
	ON gn.status_ID = mc.status_ID
order by mc.UID;

ALTER TABLE my_contacts
	DROP COLUMN status;

