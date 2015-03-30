DROP FUNCTION IF EXISTS user_modification() CASCADE;
CREATE FUNCTION user_modification() RETURNS TRIGGER AS $$
	BEGIN
		NEW."last_modified" := current_timestamp;
		RETURN NEW;
	END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS user_last_modification ON public."UserAccount";
CREATE TRIGGER user_last_modification BEFORE UPDATE ON public."UserAccount"
FOR EACH ROW EXECUTE PROCEDURE user_modification();

DROP TRIGGER IF EXISTS user_last_modification ON public."Organisation";
CREATE TRIGGER orga_last_modification BEFORE UPDATE ON public."Organisation"
FOR EACH ROW EXECUTE PROCEDURE user_modification();



--- A FINIR
DROP FUNCTION IF EXISTS user_usage() CASCADE;
CREATE FUNCTION user_usage() RETURNS TRIGGER AS $$
	BEGIN



	END;
$$ language 'plpgsql';


--- A FINIR
DROP TRIGGER IF EXISTS log_user_uses_device ON "Use";
CREATE TRIGGER log_user_uses_device AFTER UPDATE ON "Use"
FOR EACH ROW EXECUTE PROCEDURE user_usage();
