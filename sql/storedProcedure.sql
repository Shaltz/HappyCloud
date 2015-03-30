DROP FUNCTION IF EXISTS "functionTest"();
CREATE FUNCTION "functionTest"() RETURNS VOID AS $functionTest$
	BEGIN
		RAISE notice 'je fais une procedure stockée';
	END;
$functionTest$ language 'plpgsql';


DROP FUNCTION IF EXISTS "isAUser"(tokken varchar,email varchar,password varchar);
CREATE FUNCTION "isAUser"(tokken varchar,email varchar,password varchar) RETURNS text

	AS $isAUser$
		DECLARE result int;
	  			isValid boolean;
	  			pswhash boolean;
	  			verifPwd boolean;
		BEGIN
			IF tokken IS NOT NULL THEN
				SELECT "ID_User" FROM "User" WHERE "User"."authentication_tokken" = tokken INTO result;

			ELSE IF email & password

				SELECT "ID_User" FROM "User" WHERE "User"."email" = email AND "User"."password" = crypt(password, "User"."password") INTO result;

				IF verifPwd IS TRUE THEN
					SELECT "ID_User" FROM "User" WHERE "User"."email" = email AND "User"."password" = password INTO result;
				ELSE
					result := null;






			ELSE
				result := null;

			END IF;


			IF result IS NOT NULL THEN

	  			INSERT INTO "Log"("type_log","FK_ID_User") VALUES('CONNECT',result);
				RAISE notice '%',result;

				IF tokken NOTNULL THEN
	  				RETURN result;

	  			ELSE IF email & password
	  				RETURN (SELECT "authentication_tokken" FROM "User" where "ID_User" = result);

				ELSE
		  			RETURN null;

		  		END IF;

		  	ELSE
		  		RAISE warning 'Their is an error %', result;

			END IF;

		END;
$isAUser$ language 'plpgsql';
-- http://dba.stackexchange.com/questions/1883/how-do-i-install-pgcrypto-for-postgresql-in-ubuntu-server
-- phpass -> nodeJS (hashage/sallage/crypto)

DROP FUNCTION IF EXiSTS "user_assign_games"(int);
CREATE FUNCTION "user_assign_games"(int) RETURNS text
	AS $user_assign_games$
		BEGIN
			RETURN SELECT * FROM "Assign" where "Assign".ID_User = $1;
		END;
$user_assign_games$ language 'plpgsql';



CREATE OR REPLACE FUNCTION ""
