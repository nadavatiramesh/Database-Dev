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

--1. answer 

/*select shipname from ships,classes where classes.CLASSNAME = ships.SHIPCLASS and country = 'USA' order by ships.SHIPNAME*/



CREATE OR REPLACE PROCEDURE shipsByCountry (country classes.country%TYPE) AS
  CURSOR c1 IS (select shipname from ships 
  where ships.SHIPCLASS = any(select classname from classes where country = country));
  
  shipsname VARCHAR(20);
BEGIN
 DBMS_OUTPUT.PUT_LINE('Ships made by' ||country||' are :');
  OPEN c1;
  LOOP
    FETCH c1 INTO shipsname;
    EXIT WHEN (c1%NOTFOUND);
    DBMS_OUTPUT.PUT_LINE(shipsname);
  END LOOP;
  CLOSE c1;
END;
/

SET SERVEROUTPUT ON;
CALL shipsByCountry('USA');

--my confidence level 9

--2.Answer

CREATE OR REPLACE FUNCTION battleYear(battlename battles.battlename%type) RETURN BATTLES.BATTLEYR%TYPE AS
CURSOR c2 IS (select battleyr from battles where battlename = battlename);
  
  by1 BATTLES.BATTLEYR%TYPE;
BEGIN
OPEN c2;
  LOOP
    FETCH c2 INTO by1;
    EXIT WHEN (c2%NOTFOUND);
     return by1;
  END LOOP;
  CLOSE c2;
  
   
END;

SELECT battleYear('Guadalcanal') FROM dual;

--my confidence level 10

--3 answer

select shipname from ships,classes where classes.CLASSNAME = ships.SHIPNAME and country = 'USA' and ships.LAUNCHYR < battleYear('Guadalcanal');

--my confidence level 9

--4 Answer

SELECT b.battleyr,  s.launchyr
FROM battles b,  ships s,  outcomes o
WHERE o.ship     = s.shipname
AND b.battlename = o.battle
AND s.shipname   = 'California';

CREATE OR REPLACE PROCEDURE valid_Launch(p_shipname Ships.shipname%TYPE)
AS  v_battleYr Battles.battleyr%TYPE;
  v_shiplaunchYr Ships.launchyr%TYPE;
BEGIN
  SELECT b.battleyr,    s.launchyr
  INTO v_battleYr,    v_shiplaunchYr
  FROM battles b,    ships s,    outcomes o
  WHERE o.ship       = s.shipname  AND b.battlename   = o.battle
  AND s.shipname     = p_shipname;
  IF (v_shiplaunchYr > v_battleyr) THEN
    dbms_output.put_line('ship '||p_shipname||' had invalid launch year and it is now yet to NULL');
    UPDATE ships SET launchyr = NULL WHERE shipname = p_shipname;
  ELSE
    dbms_output.put_line('ship '||p_shipname||' has a valid launch year');
  END IF;
END;


Executing procedure
INSERT INTO Outcomes (ship, battle, outcome) VALUES ('Wisconsin', 'Guadalcanal', 'ok');
CALL valid_Launch('Wisconsin');
CALL valid_Launch('California');
ROLLBACK;

---my confidence level 10

--5 Answer

CREATE OR REPLACE PROCEDURE insert_outcomes( p_shipname ships.shipname%type,
    p_battle Battles.battlename%type,
    p_outcome Outcomes.outcome%type)
AS
  v_shipcount   NUMBER;
  v_battlecount NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_shipcount FROM ships WHERE shipname = p_shipname;
  IF v_shipcount = 0 THEN
    INSERT INTO ships VALUES
      (p_shipname,NULL,NULL
      );
  END IF;



  SELECT COUNT(*) INTO v_battlecount FROM battles WHERE battlename = p_battle;
  IF v_battlecount = 0 THEN
    INSERT INTO battles VALUES
      (p_battle,NULL
      );
  END IF;
  INSERT INTO outcomes VALUES
    (p_shipname,p_battle,p_outcome
    );
END;
/
CALL insert_outcomes ('myShip', 'myBattle', 'ok');

SELECT * FROM ships WHERE shipname='myShip';
SELECT * FROM battles WHERE battlename = 'myBattle';
SELECT * FROM outcomes;
ROLLBACK;


---my confidence level 10