
INSERT INTO "Organisation" ("name","email")
VALUES ('monOrganisation','monEmail@hotmail.com');

INSERT INTO "Organisation" ("name","email")
VALUES ('tonOrganisation','monEmail@gmail.com');


INSERT INTO "User"("display_name","email","password","role")
VALUES  ('Tenji', 'patricepetit@hotmail.com','pass1', 'ADMIN');

INSERT INTO "User"("display_name","email","password","role")
VALUES  ('DUPOND','DUPOND@hotmail.com','pass2', 'USER');

INSERT INTO "User"("display_name","email","password","role")
VALUES  ('DUPONT','DUPONT@hotmail.com','pass3','USER');



INSERT INTO "Device" ("ID_Device","name")
VALUES  ('a2', 'ipad');
INSERT INTO "Device" ("ID_Device","name")
VALUES  ('a1', 'ipad');

INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('iquizzVendome', 'iquizzVendome','1.0.1', 'game/iquizz', 'toto');
INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('iquizzVendome', 'iquizzVendome','1.0.2', 'game/iquizz', 'toto');
INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('iquizzMezzo', 'iquizzMezzo','1.0.1', 'game/iquizz', 'toto');
INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('irallyeChateau1', 'irallyeChateau1','1.0.1', 'game/iquizz', 'toto');
INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('irallyeSiemens', 'irallyeSiemens','1.0.1', 'game/iquizz', 'toto');
INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('irallyeChateau2', 'irallyeChateau2','1.0.1', 'game/iquizz', 'toto');
INSERT INTO "Game" ("shortName", display_name, version, path, "metaData")
VALUES ('irallyeChateau2', 'irallyeChateau2','1.0.2', 'game/iquizz', 'toto');


INSERT INTO "Install"
VALUES(1,'a1',DEFAULT);
INSERT INTO "Assign"
VALUES(1,1,DEFAULT);
INSERT INTO "Assign"
VALUES(2,2,DEFAULT);
