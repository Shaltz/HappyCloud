DROP FUNCTION IF EXISTS "functionTest"();
CREATE OR REPLACE FUNCTION "functionTest"() RETURNS VOID AS $body$
BEGIN

raise notice 'je fais une procedure stockée';

END;
$body$ language 'plpgsql';

DROP FUNCTION IF EXISTS "isAUser"(varchar,varchar);
CREATE OR REPLACE FUNCTION "isAUser"(varchar,varchar) RETURNS text AS $body$
DECLARE result int;
  isValid boolean;
BEGIN
SELECT "ID_User" FROM "UserAccount" WHERE "UserAccount"."email_user" = $1 AND "UserAccount".password = $2 INTO result;
raise notice '%',result;
IF result NOTNULL THEN
  INSERT INTO "Log"("type_log","FK_ID_User")
  VALUES('CONNECT',result);
  RETURN (SELECT "authentication_tokken" FROM "UserAccount" where "ID_User" = result);
ELSE
  RETURN result;
END IF;
END;
$body$ language 'plpgsql';
-- http://dba.stackexchange.com/questions/1883/how-do-i-install-pgcrypto-for-postgresql-in-ubuntu-server

DROP FUNCTION IF EXiSTS "createTokken"();
CREATE OR REPLACE FUNCTION "createTokken"() RETURNS varchar AS $body$
BEGIN

END;
$body$ language 'plpgsql';

DROP FUNCTION IF EXiSTS "user_assign_games"(int);
CREATE OR REPLACE FUNCTION "user_assign_games"(int) RETURNS text
AS $body$
BEGIN
	RETURN SELECT * FROM "Assign" where "Assign".ID_User = $1;
END;
$body$ language 'plpgsql';

