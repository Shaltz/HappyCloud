CREATE TYPE Activity AS ENUM ('ACQUIRE','ASSIGN','CONNECT','CREATE','DISCONNECT','INSTALL','MODIFY','UPDATE');

CREATE TABLE IF NOT EXISTS public."Organisation"(
	"ID_Organisation" SERIAL PRIMARY KEY,
	"name" varchar(50) NOT NULL,
	"email" varchar(50) NOT NULL,
	"active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS public."UserAccount"(
	"ID_User" SERIAL PRIMARY KEY,
	"display_Name" varchar(50) NOT NULL,
	"email" varchar(50) UNIQUE NOT NULL,
	"password" varchar(50) NOT NULL,
	"access_Level" integer NOT NULL,
	"FK_ID_Organisation" INT NOT NULL,
	"active"  boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Game"(
	"ID_Game" SERIAL PRIMARY KEY,
	"short_Name" varchar(50) NOT NULL,
	"display_Name" varchar(50) NOT NULL,
	"version" varchar(50) NOT NULL,
	"path" varchar(50) NOT NULL,
	"metaData" Text NOT NULL,
	"active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Device"(
	"Unique_ID_Device" varchar(50) PRIMARY KEY,
	"plateForm_Type" varchar(50) NOT NULL,
	"authentification_Tokken" varchar(50) NOT NULL,
	"active" boolean NOT NULL
);

CREATE TABLE IF NOT EXISTS public."Activity"(
	"ID_activity" SERIAL PRIMARY KEY,
	"data_Activity" timeStamptz NOT NULL,
	"type_Activity" Activity NOT NULL,
	"FK_ID_Game" INT NOT NULL,
	"FK_ID_Device" varchar(50) NOT NULL,
	"FK_ID_User" INT NOT NULL,
	"FK_ID_Organisation" INT NOT NULL
);

ALTER TABLE public."UserAccount" ADD CONSTRAINT "FK_ID_Organisation_UserAccount" FOREIGN KEY ("FK_ID_Organisation") REFERENCES public."Organisation"("ID_Organisation");
ALTER TABLE public."Activity" ADD CONSTRAINT "FK_ID_Game_Activity" FOREIGN KEY ("FK_ID_Game") REFERENCES public."Game"("ID_Game");
ALTER TABLE public."Activity" ADD CONSTRAINT "FK_ID_Device_Activity" FOREIGN KEY ("FK_ID_Device") REFERENCES public."Device"("Unique_ID_Device");
ALTER TABLE public."Activity" ADD CONSTRAINT "FK_ID_User_Activity" FOREIGN KEY ("FK_ID_User") REFERENCES public."UserAccount"("ID_User");
ALTER TABLE public."Activity" ADD CONSTRAINT "FK_ID_Organisation_Activity" FOREIGN KEY ("FK_ID_Organisation") REFERENCES public."Organisation"("ID_Organisation");
