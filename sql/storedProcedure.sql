DROP FUNCTION IF EXISTS "functionTest"();
CREATE FUNCTION "functionTest"() RETURNS VOID AS $functionTest$
	BEGIN
		RAISE notice 'je fais une procedure stockée';
	END;
$functionTest$ language 'plpgsql';


CREATE OR REPLACE FUNCTION "create_tokken"() RETURNS varchar(100) AS $create_tokken$
	DECLARE
		key varchar(100);
		BEGIN
			key := crypt(random()::text,gen_salt('md5'))::text || crypt(now()::text,gen_salt('md5'))::text;
			RETURN key;
		END;
$create_tokken$ language 'plpgsql';


DROP FUNCTION IF EXISTS "isValidUser"(argtokken varchar,argemail varchar,argpassword varchar);
CREATE FUNCTION "isValidUser"(argtokken varchar,argemail varchar,argpassword varchar) RETURNS text AS $isValidUser$
		DECLARE result int;
			tokken text;
		BEGIN
			IF argtokken IS NOT NULL THEN

				SELECT "ID_User", "authentication_tokken" FROM "User" WHERE "User"."authentication_tokken" = argtokken INTO result,tokken;

			ELSEIF argemail IS NOT NULL AND argpassword IS NOT NULL THEN

				SELECT "ID_User","authentication_tokken" FROM "User" WHERE "User"."email" = argemail AND password = crypt(argpassword, password) INTO result,tokken;

			ELSE

				result := null;
				tokken := null;

			END IF;

			IF result IS NOT NULL THEN

	  	-- 		INSERT INTO "Log"("type_log","FK_ID_User") VALUES('CONNECT',result);
				-- RAISE notice '%',result;
				PERFORM "logConnect"(result);

			END IF;
			return tokken;

		END;
$isValidUser$ language 'plpgsql';
-- http://dba.stackexchange.com/questions/1883/how-do-i-install-pgcrypto-for-postgresql-in-ubuntu-server
-- pgcrypt -> nodeJS (hashage/sallage/crypto)

DROP FUNCTION IF EXISTS "user_assign_games"(int);
CREATE FUNCTION "user_assign_games"(int) RETURNS text
	AS $user_assign_games$
		BEGIN
			RETURN(SELECT * FROM "Assign" where "Assign".ID_User = $1);
		END;
$user_assign_games$ language 'plpgsql';



CREATE OR REPLACE FUNCTION "logInstall"(ID_User integer, ID_Game integer, ID_Device integer)
	AS $logInstall$
		BEGIN
			IF ID_User IS NOT NULL AND ID_Game IS NOT NULL AND ID_Device IS NOT NULL AND
				PERFORM "writeToLog"(ID_User, ID_Game, ID_Device, 'INSTALL');
			ELSE
				RAISE EXCEPTION 'Erreur d\'écriture dans les logs ! Il manque un ou plusieurs arguments pour executer logInstall!';
			END IF;
		END;

$logInstall$ language 'plpgsql'


CREATE OR REPLACE FUNCTION "logDelete"(ID_User integer, ID_Game integer, ID_Device integer)
	AS $logDelete$
		BEGIN
			IF ID_User IS NOT NULL AND ID_Game IS NOT NULL AND ID_Device IS NOT NULL AND
				PERFORM "writeToLog"(ID_User, ID_Game, ID_Device, 'DELETE');
			ELSE
				RAISE EXCEPTION 'Erreur d\'écriture dans les logs ! Il manque un ou plusieurs arguments pour executer logDelete!';
			END IF;
		END;

$logDelete$ language 'plpgsql'


CREATE OR REPLACE FUNCTION "logConnect"(ID_User integer)
	AS $logConnect$
		BEGIN
			IF ID_User IS NOT NULL
				PERFORM "writeToLog"(ID_User, null, null, 'CONNECT');
			ELSE
				RAISE EXCEPTION 'Erreur d\'écriture dans les logs ! Il manque un ou plusieurs arguments pour executer logConnect!';
			END IF;
		END;

$logConnect$ language 'plpgsql'



CREATE OR REPLACE FUNCTION "writeToLog"(ID_User integer, ID_Game integer, ID_Device integer, action "typeActivity")
	AS $writeToLog$
		BEGIN
			INSERT INTO "Log"
			VALUES (
				DEFAULT,
				current_timestamp,
				action,
				ID_User,
				ID_Device,
				ID_GAME
				);
		END;

$writeToLog$ language 'plpgsql'


