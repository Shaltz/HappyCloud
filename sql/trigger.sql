DROP FUNCTION IF EXISTS user_modification() CASCADE;
CREATE OR REPLACE FUNCTION user_modification() RETURNS TRIGGER AS $$
BEGIN
  NEW."last_modified" := current_timestamp;
  RETURN NEW;
END;
$$ language 'plpgsql';

--DROP TRIGGER IF EXISTS user_last_modification ON public."User";
--DROP TRIGGER IF EXISTS user_last_modification ON public."Organisation";
CREATE TRIGGER user_last_modification BEFORE UPDATE ON public."User"
FOR EACH ROW EXECUTE PROCEDURE user_modification() ;
CREATE TRIGGER orga_last_modification BEFORE UPDATE ON public."Organisation"
FOR EACH ROW EXECUTE PROCEDURE user_modification() ;

--- A FINIR
DROP FUNCTION IF EXISTS hash_pwd_Proc() CASCADE;
CREATE FUNCTION hash_pwd_Proc() RETURNS TRIGGER AS $$
	BEGIN
		NEW."password" := crypt(NEW."password", gen_salt('MD5'));
		RETURN NEW;
	END;
$$ language 'plpgsql';

DROP FUNCTION IF EXISTS user_tokken() CASCADE;
CREATE OR REPLACE FUNCTION user_tokken() RETURNS TRIGGER AS $$
BEGIN
  NEW."authentication_tokken" := "create_tokken"();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- DROP TRIGGER IF EXISTS user_create_tokken ON public."User";
CREATE TRIGGER user_create_tokken BEFORE INSERT ON public."User"
FOR EACH ROW EXECUTE PROCEDURE user_tokken() ;


--- A FINIR
-- DROP TRIGGER IF EXISTS hash_pwd ON "User" CASCADE;
CREATE TRIGGER hash_pwd BEFORE INSERT OR UPDATE ON "User"
FOR EACH ROW EXECUTE PROCEDURE hash_pwd_Proc();
