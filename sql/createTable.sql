-- Databbase POSTGRESQL

DROP TABLE IF EXISTS public."Log" CASCADE;
DROP TABLE IF EXISTS public."Use" CASCADE;
DROP TABLE IF EXISTS public."Install" CASCADE;
DROP TABLE IF EXISTS public."Assign" CASCADE;
DROP TABLE IF EXISTS public."User" CASCADE;
DROP TABLE IF EXISTS public."Organisation" CASCADE;
DROP TABLE IF EXISTS public."Game" CASCADE;
DROP TABLE IF EXISTS public."Device" CASCADE;
DROP TYPE IF EXISTS public."Type_Log" CASCADE;
DROP TYPE IF EXISTS public."Type_Access" CASCADE;

CREATE TYPE public."Type_Log" AS ENUM ('CONNECT','CREATE','DISCONNECT','DELETE','INSTALL','MODIFY');
CREATE TYPE public."Type_Access" AS ENUM ('ADMIN','USER');

CREATE TABLE IF NOT EXISTS public."Organisation"(
	"ID_Organisation" SERIAL PRIMARY KEY,
	"name" varchar(50) NOT NULL,
	"email" varchar(50) UNIQUE NOT NULL,
	"created" timeStamptz DEFAULT current_timestamp NOT NULL,
	"active" boolean NOT NULL DEFAULT TRUE,
	"last_modified" timeStamptz NULL
);

CREATE TABLE IF NOT EXISTS public."User"(
	"ID_User" SERIAL PRIMARY KEY,
	"FK_ID_Organisation" INT NULL,
	"display_name" varchar(50) NOT NULL,
	"email" varchar(50) UNIQUE NOT NULL,
	"password" varchar(50) NOT NULL,
	"authentication_tokken" varchar(100) UNIQUE NULL,
	"role" "Type_Access" NOT NULL,
	"created" timeStamptz DEFAULT current_timestamp NOT NULL,
	"last_modified" timestamptz NULL,
	"active"  boolean NOT NULL DEFAULT TRUE,
	CONSTRAINT "FK_ID_Organisation_User" FOREIGN KEY ("FK_ID_Organisation") REFERENCES public."Organisation"("ID_Organisation")
);

CREATE TABLE IF NOT EXISTS public."Game"(
	"ID_Game" SERIAL PRIMARY KEY,
	"shortName" varchar(50) NOT NULL,
	"display_name" varchar(50) NOT NULL,
	"version" varchar(50) NOT NULL,
	"path" varchar(50) NOT NULL,
	"metaData" Text NOT NULL,
	"active" boolean DEFAULT TRUE NOT NULL,
	CONSTRAINT "UQ_name_version" UNIQUE ("shortName","version")
);

CREATE TABLE IF NOT EXISTS public."Device"(
	"ID_Device" varchar(50) PRIMARY KEY,
	"name" varchar(50) NULL,
	"active" boolean DEFAULT TRUE NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Use"(
	"FK_ID_User" int NOT NULL REFERENCES public."User"("ID_User"),
	"FK_ID_Device" varchar(50) NOT NULL REFERENCES public."Device"("ID_Device"),
	"date_autorisation" timeStamptz DEFAULT current_timestamp NOT NULL,
	CONSTRAINT "PK_Use" PRIMARY KEY ("FK_ID_User","FK_ID_Device")

);

CREATE TABLE IF NOT EXISTS public."Install"(
	"FK_ID_Game" int NOT NULL REFERENCES public."Game"("ID_Game"),
	"FK_ID_Device" varchar(50) NOT NULL REFERENCES public."Device"("ID_Device"),
	"date_install" timeStamptz DEFAULT current_timestamp NOT NULL,
	CONSTRAINT "PK_Install" PRIMARY KEY ("FK_ID_Game","FK_ID_Device")
);

CREATE TABLE IF NOT EXISTS public."Assign"(
	"FK_ID_User" int NOT NULL REFERENCES public."User"("ID_User"),
	"FK_ID_Game" int NOT NULL REFERENCES public."Game"("ID_Game"),
	"date_assign" timeStamptz DEFAULT current_timestamp NOT NULL,
	CONSTRAINT "PK_Assign" PRIMARY KEY ("FK_ID_User","FK_ID_Game")
);

CREATE TABLE IF NOT EXISTS public."Log"(
	"ID_Log" SERIAL PRIMARY KEY,
	"date_log"  timeStamptz DEFAULT current_timestamp NOT NULL,
	"type_log" "Type_Log" NOT NULL,
	"FK_ID_Game" INT NULL DEFAULT NULL,
	"FK_ID_Device" varchar(50)  NULL DEFAULT NULL,
	"FK_ID_User" INT NULL DEFAULT NULL
);

ALTER TABLE public."Log" ADD CONSTRAINT "FK_ID_Game_Log" FOREIGN KEY ("FK_ID_Game") REFERENCES public."Game"("ID_Game");
ALTER TABLE public."Log" ADD CONSTRAINT "FK_ID_Device_Log" FOREIGN KEY ("FK_ID_Device") REFERENCES public."Device"("ID_Device");
ALTER TABLE public."Log" ADD CONSTRAINT "FK_ID_User_Log" FOREIGN KEY ("FK_ID_User") REFERENCES public."User"("ID_User");
