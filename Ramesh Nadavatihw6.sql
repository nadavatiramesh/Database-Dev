DROP TABLE Outcomes CASCADE CONSTRAINTS;
DROP TABLE Battles CASCADE CONSTRAINTS;
DROP TABLE Ships CASCADE CONSTRAINTS;
DROP TABLE Classes CASCADE CONSTRAINTS;

CREATE TABLE Classes (
    className    VARCHAR2(20),
    typeClass    CHAR(2),
    country      VARCHAR2(15),
    numGuns      INT,
    bore         INT,
    displacement INT,
    CONSTRAINT pkClasses PRIMARY KEY (className),
    CHECK (typeClass IN ('bb', 'bc'))
  );

CREATE TABLE Ships
  (
    shipName  VARCHAR2(20),
    shipClass VARCHAR2(20),
    launchYr  INT,
    CONSTRAINT pkShips PRIMARY KEY (shipName),
    CONSTRAINT fkClasses FOREIGN KEY (shipClass) REFERENCES Classes (className)
  );

CREATE TABLE Battles
  (
    battleName VARCHAR2(20),
    battleYr   INT,
    CONSTRAINT pkBattles PRIMARY KEY (battleName)
  );

CREATE TABLE Outcomes
  (
    ship    VARCHAR2(20),
    battle  VARCHAR2(20),
    outcome VARCHAR2(10),
    CONSTRAINT pkOutcomes PRIMARY KEY (ship, battle),
    CHECK (outcome IN ('sunk', 'ok', 'damaged')),
    CONSTRAINT fkShips FOREIGN KEY (ship) REFERENCES Ships (shipName),
    CONSTRAINT fkBattles FOREIGN KEY (battle) REFERENCES Battles (battleName)
  );

INSERT INTO Classes VALUES ('Bismarck', 'bb', 'Germany', 8, 15, 42000);
INSERT INTO Classes VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO Classes VALUES ('Kongo', 'bc', 'Japan', 8, 14, 32000);
INSERT INTO Classes VALUES ('North Carolina', 'bb', 'USA', 9, 16, 37000);
INSERT INTO Classes VALUES ('Renown', 'bc', 'Gt. Britain', 6, 15, 32000);
INSERT INTO Classes VALUES ('Revenge', 'bb', 'Gt. Britain', 8, 15, 29000);
INSERT INTO Classes VALUES ('Tennessee', 'bb', 'USA', 12, 14, 32000);
INSERT INTO Classes VALUES ('Yamato', 'bb', 'Japan', 9, 18, 65000);

INSERT INTO Battles VALUES ('Denmark Strait', 1941);
INSERT INTO Battles VALUES ('Guadalcanal', 1942);
INSERT INTO Battles VALUES ('North Cape', 1943);
INSERT INTO Battles VALUES ('Surigao Strait', 1944);

INSERT INTO Ships VALUES ('California', 'Tennessee', 1921);
INSERT INTO Ships VALUES ('Haruna', 'Kongo', 1915);
INSERT INTO Ships VALUES ('Hiei', 'Kongo', 1914);
INSERT INTO Ships VALUES ('Iowa', 'Iowa', 1943);
INSERT INTO Ships VALUES ('Kirishima', 'Kongo', 1915);
INSERT INTO Ships VALUES ('Kongo', 'Kongo', 1913);
INSERT INTO Ships VALUES ('Missouri', 'Iowa', 1944);
INSERT INTO Ships VALUES ('Musashi', 'Yamato', 1942);
INSERT INTO Ships VALUES ('New Jersey', 'Iowa', 1943);
INSERT INTO Ships VALUES ('North Carolina', 'North Carolina', 1941);
INSERT INTO Ships VALUES ('Ramillies', 'Revenge', 1917);
INSERT INTO Ships VALUES ('Renown', 'Renown', 1916);
INSERT INTO Ships VALUES ('Repulse', 'Renown', 1916);
INSERT INTO Ships VALUES ('Resolution', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Revenge', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Royal Oak', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Royal Sovereign', 'Revenge', 1916);
INSERT INTO Ships VALUES ('Tennessee', 'Tennessee', 1920);
INSERT INTO Ships VALUES ('Washington', 'North Carolina', 1941);
INSERT INTO Ships VALUES ('Wisconsin', 'Iowa', 1944);
INSERT INTO Ships VALUES ('Yamato', 'Yamato', 1941);

INSERT INTO Outcomes VALUES ('California', 'Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Kirishima', 'Guadalcanal', 'sunk');
INSERT INTO Outcomes VALUES ('North Carolina', 'Guadalcanal', 'damaged');
INSERT INTO Outcomes VALUES ('Tennessee', 'Surigao Strait', 'ok');
INSERT INTO Outcomes VALUES ('Washington', 'Guadalcanal', 'ok');
INSERT INTO Outcomes VALUES ('North Carolina', 'Surigao Strait', 'ok');

commit;





--1) Answer
CREATE OR REPLACE TRIGGER trigger_update_display 
BEFORE UPDATE OR INSERT ON classes
FOR EACH ROW
Begin
If (:NEW.displacement > 35000)
then
:NEW.displacement := 35000;
END IF; 
End;
---My confidence level is 10.

--2) Answer
CREATE OR REPLACE TRIGGER trigger_Lyear_Byear
AFTER INSERT OR UPDATE ON outcomes
FOR EACH ROW

DECLARE

launch_year ships.launchyr%type;
battle_year battles.battleyr%type;

BEGIN

Select launchyr into launch_year from ships where shipname=  :NEW.ship;
Select battleyr into battle_year from battles where battlename= :NEW.battle;

IF(launch_year>battle_year)  THEN

UPDATE ships SET launchyr=battle_year WHERE shipname= :NEW.ship;

END IF;

END;

--My confidence level is 10.

---3) Answer
CREATE OR REPLACE TRIGGER Trigger_ships_outcomes
BEFORE INSERT ON ships
FOR EACH ROW

DECLARE
new_shipclass ships.shipclass%type;
count_newclass Integer;

BEGIN

new_shipclass := :NEW.shipclass;

SELECT COUNT(*) INTO count_newclass FROM CLASSES WHERE classname=new_shipclass;

IF(count_newclass=0)  THEN

INSERT INTO classes(classname) VALUES(new_shipclass);
END IF;
END;

---My confidence level is 10.









---4) Answer
CREATE OR REPLACE FORCE VIEW USAShips AS 
SELECT shipName, className, numGuns, bore
FROM Classes C1, Ships S1
WHERE C1.className = S1.shipClass AND C1.country = 'USA';




CREATE OR REPLACE TRIGGER Trigger_view_usaships
INSTEAD OF INSERT ON usaShips 
FOR EACH ROW 
DECLARE 

count_classname NUMBER;
count_shipname NUMBER;

BEGIN

SELECT COUNT(*) INTO count_classname FROM classes WHERE classname = :NEW.classname;

IF (count_classname = 0)  THEN

INSERT INTO classes(classname, numguns, bore, country) VALUES (:NEW.classname, :NEW.numguns, :NEW.bore, 'USA' );

ELSE 

UPDATE Classes SET numguns = :NEW.numguns, bore = :NEW.bore, country = 'USA' WHERE classname = :NEW.classname;
END IF;

SELECT COUNT(*) INTO count_shipname FROM ships WHERE shipname = :NEW.shipname;

IF (count_shipname = 0)  THEN
INSERT INTO ships  (shipname, shipclass ) VALUES (:NEW.shipname, :NEW.classname);

ELSE

UPDATE ships SET shipclass = :NEW.classname, shipname = :NEW.shipname WHERE shipname = :NEW.shipname;
 END IF;
END;

---My confidence level is 10.



---5)Answer
CREATE TABLE logTblUpdateShips(info VARCHAR(100), timeInserted DATE);

--Statement level trigger:
CREATE OR REPLACE TRIGGER tg_stmt_update_ships
BEFORE UPDATE ON ships
BEGIN
INSERT INTO logTblUpdateShips VALUES('executed an update statement on ships table',SYSDATE);
END;

--Row level trigger:

CREATE OR REPLACE TRIGGER tg_row_update_ships
BEFORE UPDATE ON ships
FOR EACH ROW
BEGIN
INSERT INTO logTblUpdateShips VALUES('A Row is updated on ships table',SYSDATE);
END;

---My confidence level is 10.
