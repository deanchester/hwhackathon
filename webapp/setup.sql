CREATE SCHEMA `red-sky` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;

CREATE USER 'red-sky-web'@'localhost' IDENTIFIED BY 'slkjfdlksajdfalj';

CREATE TABLE USER_DETAIL
(
ID BIGINT AUTO_INCREMENT NOT NULL,
USERNAME VARCHAR(100) NOT NULL,
PASSWORD VARCHAR(100) NOT NULL,
FORENAME VARCHAR(100) NOT NULL,
SURNAME VARCHAR(100) NOT NULL,
EMAIL VARCHAR(100),
MOBILE VARCHAR(100),
PRIMARY KEY(ID)
);

ALTER TABLE USER_DETAIL
ADD UNIQUE INDEX username_unique (USERNAME ASC);

ALTER TABLE USER_DETAIL
ADD UNIQUE INDEX email_unique (email ASC);

GRANT INSERT, SELECT, UPDATE, DELETE ON USER_DETAIL TO 'red-sky-web'@'localhost';

CREATE TABLE FARM
(
ID BIGINT AUTO_INCREMENT NOT NULL,
NAME VARCHAR(100) NOT NULL,
PRIMARY KEY(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON FARM TO 'red-sky-web'@'localhost';

CREATE TABLE FARMER
(
USER_DETAIL_ID BIGINT NOT NULL,
FARM_ID BIGINT NOT NULL,
PRIMARY KEY(USER_DETAIL_ID, FARM_ID),
FOREIGN KEY(USER_DETAIL_ID) REFERENCES USER_DETAIL(ID),
FOREIGN KEY(FARM_ID) REFERENCES FARM(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON FARMER TO 'red-sky-web'@'localhost';

CREATE TABLE USER_ROLE
(
ROLE VARCHAR(100) NOT NULL,
DESCRIPTION VARCHAR(1000) NOT NULL,
PRIMARY KEY(ROLE)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON USER_ROLE TO 'red-sky-web'@'localhost';

CREATE TABLE USER_ROLE_LINK
(
USER_DETAIL_ID BIGINT NOT NULL,
USER_ROLE VARCHAR(100) NOT NULL,
PRIMARY KEY(USER_DETAIL_ID, USER_ROLE),
FOREIGN KEY(USER_DETAIL_ID) REFERENCES USER_DETAIL(ID),
FOREIGN KEY(USER_ROLE) REFERENCES USER_ROLE(ROLE)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON USER_ROLE_LINK TO 'red-sky-web'@'localhost';

CREATE TABLE FARM_AREA
(
ID BIGINT AUTO_INCREMENT NOT NULL,
FARM_ID BIGINT NOT NULL,
NAME VARCHAR(100) NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(FARM_ID) REFERENCES FARM(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON FARM_AREA TO 'red-sky-web'@'localhost';

CREATE TABLE ANIMAL_TYPE
(
ID BIGINT AUTO_INCREMENT NOT NULL,
NAME VARCHAR(100) NOT NULL,
PRIMARY KEY(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON ANIMAL_TYPE TO 'red-sky-web'@'localhost';

CREATE TABLE ANIMAL
(
ID BIGINT AUTO_INCREMENT NOT NULL,
FARM_ID BIGINT NOT NULL,
ANIMAL_TYPE_ID BIGINT NOT NULL,
PRIMARY KEY(ID),
FOREIGN KEY(FARM_ID) REFERENCES FARM(ID),
FOREIGN KEY(ANIMAL_TYPE_ID) REFERENCES ANIMAL_TYPE(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON ANIMAL TO 'red-sky-web'@'localhost';

CREATE TABLE SENSOR
(
ID BIGINT AUTO_INCREMENT,
NAME VARCHAR(100) NOT NULL,
PRIMARY KEY(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON SENSOR TO 'red-sky-web'@'localhost';

CREATE TABLE ANIMAL_SENSOR_LINK
(
ANIMAL_ID BIGINT NOT NULL,
SENSOR_ID BIGINT NOT NULL,
PRIMARY KEY(ANIMAL_ID, SENSOR_ID),
FOREIGN KEY(ANIMAL_ID) REFERENCES ANIMAL(ID),
FOREIGN KEY(SENSOR_ID) REFERENCES SENSOR(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON ANIMAL_SENSOR_LINK TO 'red-sky-web'@'localhost';

CREATE TABLE SENSOR_DATA
(
SENSOR_ID BIGINT AUTO_INCREMENT,
DATE_TIME DATETIME, 
ACCELEROMETER_X MEDIUMINT,
ACCELEROMETER_Y MEDIUMINT,
ACCELEROMETER_Z MEDIUMINT,
PRIMARY KEY(ID, DATE_TIME),
FOREIGN KEY(SENSOR_ID) REFERENCES SENSOR(ID)
);

GRANT INSERT, SELECT, UPDATE, DELETE ON SENSOR_DATA TO 'red-sky-web'@'localhost';

INSERT INTO USER_DETAIL VALUES (1, "john.collins@gmail.com", "changeME123", "John", "Collins", "john.collins@gmail.com", "0854654555");
INSERT INTO FARM VALUES (1, "Home Farm");
INSERT INTO FARMER VALUES (1, 1);
INSERT INTO USER_ROLE VALUES ("FARMER", "Farmer");
INSERT INTO USER_ROLE_LINK VALUES (1, "FARMER");
INSERT INTO FARM_AREA VALUES (1, 1, "The Yard");
INSERT INTO ANIMAL_TYPE VALUES (1, "Sheep");
INSERT INTO ANIMAL VALUES (1, 1, 1);
--INSERT INTO SENSOR VALUES ();
--INSERT INTO ANIMAL_SENSOR_LINK VALUES (1, 1, );