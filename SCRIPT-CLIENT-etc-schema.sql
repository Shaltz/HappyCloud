
CREATE OR REPLACE FUNCTION update_modification_date() RETURNS TRIGGER AS $$
BEGIN
	NEW.modification_date := NOW();
	RETURN NEW;
END;
$$ LANGUAGE PLPGSQL;

-- ================================================
-- ================================================

DROP TABLE IF EXISTS users;
CREATE TABLE users (
	id						serial NOT NULL,
	creation_date			timestamp NOT NULL DEFAULT NOW(),
	modification_date		timestamp NOT NULL DEFAULT NOW(),
	last_connection_date	timestamp,
	name					varchar(128) NOT NULL,
	email					varchar(128) UNIQUE NOT NULL,
	password				varchar(64),
	auth_token				varchar(64) UNIQUE NOT NULL DEFAULT uuid_in(md5(random()::text || now()::text)::cstring), -- defaults to generated pseudo UUID. Unique contraint prevents possible problems.
	is_admin				boolean NOT NULL DEFAULT FALSE,

	PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS update_users_modification_date ON users;
CREATE TRIGGER update_users_modification_date BEFORE INSERT OR UPDATE ON users FOR EACH ROW EXECUTE PROCEDURE update_modification_date();

-- create default user
INSERT INTO users (
	name,
	email,
	password,
	is_admin
) VALUES (
	'Admin',
	'admin@example.com',
	'*',
	TRUE
);

-- ================================================
-- ================================================

DROP TABLE IF EXISTS games;
CREATE TABLE games (
	id					serial NOT NULL,
	creation_date		timestamp NOT NULL DEFAULT NOW(),
	modification_date	timestamp NOT NULL DEFAULT NOW(),
	name				varchar(128) UNIQUE NOT NULL, -- shortname used for references like file folder.
	display_name		varchar(128) NOT NULL,

	PRIMARY KEY (id)
);

DROP TRIGGER IF EXISTS update_games_modification_date ON games;
CREATE TRIGGER update_games_modification_date BEFORE INSERT OR UPDATE ON games FOR EACH ROW EXECUTE PROCEDURE update_modification_date();

-- ================================================
-- ================================================

DROP TABLE IF EXISTS user_games;
CREATE TABLE user_games (
	user_id			integer NOT NULL,
	game_id			integer NOT NULL,
	creation_date	timestamp NOT NULL DEFAULT NOW(),

	PRIMARY KEY (user_id, game_id)
);

-- ================================================
-- ================================================
