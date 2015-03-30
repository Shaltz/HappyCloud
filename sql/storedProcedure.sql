DROP FUNCTION IF EXISTS "functionTest"();
CREATE OR REPLACE FUNCTION "functionTest"() RETURNS VOID AS $body$
BEGIN

raise notice 'je fais une procedure stockée';

END;
$body$ language 'plpgsql';


DROP FUNCTION IF EXISTS "isAUser"(varchar,varchar,varchar);
CREATE OR REPLACE FUNCTION "isAUser"(varchar,varchar,varchar) RETURNS text
AS $body$
	DECLARE result int;
  			isValid boolean;
	BEGIN
		IF $1 NOTNULL THEN
			SELECT "ID_User" FROM "User" WHERE "User"."authentication_tokken" = $1 INTO result;

		ELSE IF $2 & $3
			SELECT "ID_User" FROM "User" WHERE "User"."email_user" = $2 AND "User"."password" = $3 INTO result;

		ELSE
			result := null;

		END IF;


		IF result NOTNULL THEN

  			INSERT INTO "Log"("type_log","FK_ID_User") VALUES('CONNECT',result);
			RAISE notice '%',result;

			IF $1 NOTNULL THEN
  				RETURN result;

  			ELSE IF $2 & $3
  				RETURN (SELECT "authentication_tokken" FROM "User" where "ID_User" = result);

			ELSE
	  			RETURN null;

	  		END IF;

	  	ELSE
	  		RAISE warning 'Their is an error %', result;

		END IF;

	END;
$body$ language 'plpgsql';
-- http://dba.stackexchange.com/questions/1883/how-do-i-install-pgcrypto-for-postgresql-in-ubuntu-server
-- phpass -> nodeJS (hashage/sallage/crypto)


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

