DROP FUNCTION IF EXISTS "createTokken"();
CREATE OR REPLACE FUNCTION "createTokken"() RETURNS varchar(32) AS $body$
DECLARE
	key varchar(50);
BEGIN
	raise notice '% %',random(), now();
	--key := 1000 * random() || now();
	key := (cast random() as text) || now();
	RETURN md5(key);
END;
$body$ language 'plpgsql';

DROP FUNCTION IF EXISTS "functionTest"();
CREATE OR REPLACE FUNCTION "functionTest"() RETURNS VOID AS $body$
BEGIN
	raise notice 'je fais une procedure stockée';
END;
$body$ language 'plpgsql';

do $$
BEGIN
	raise notice '%', "createTokken"();

END;
$$ language 'plpgsql';

