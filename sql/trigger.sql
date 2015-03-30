DROP FUNCTION IF EXISTS user_modification() CASCADE;
CREATE OR REPLACE FUNCTION user_modification() RETURNS TRIGGER AS $$
BEGIN
  NEW."last_modified" := current_timestamp;
  RETURN NEW;
END;
$$ language 'plpgsql';

DROP TRIGGER IF EXISTS user_last_modification ON public."UserAccount";
DROP TRIGGER IF EXISTS user_last_modification ON public."Organisation";
CREATE TRIGGER user_last_modification BEFORE UPDATE ON public."UserAccount"
FOR EACH ROW EXECUTE PROCEDURE user_modification() ;
CREATE TRIGGER orga_last_modification BEFORE UPDATE ON public."Organisation"
FOR EACH ROW EXECUTE PROCEDURE user_modification() ;
