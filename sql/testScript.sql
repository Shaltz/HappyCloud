CREATE TABLE testusers(username varchar(100) PRIMARY KEY, cryptpwd text, md5pwd text);
INSERT INTO testusers(username, cryptpwd, md5pwd)
    VALUES ('robby', crypt('test', gen_salt('md5')), md5('test')),
        ('artoo', crypt('test',gen_salt('md5')), md5('test'));

SELECT username, cryptpwd, md5pwd
    FROM testusers;

-- successful login
 --SELECT username  FROM testusers WHERE username = 'robby' AND cryptpwd = crypt('test', cryptpwd);
 SELECT display_name,password = crypt('pass3', password)
    FROM "User";

SELECT "isValidUser"(null,'patricepetit@hotmail.com','pass1');
