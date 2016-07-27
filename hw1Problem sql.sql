DROP TABLE Outcomes;
DROP TABLE Battles;
DROP TABLE Ships;
DROP TABLE Classes;

CREATE TABLE Classes (
  className VARCHAR2(20), 
  typeClass CHAR(2), 
  country VARCHAR2(15), 
  numGuns INTEGER, 
  bore INTEGER, 
  displacement INTEGER);

CREATE TABLE Ships (
  shipName VARCHAR2(20),
  shipClass VARCHAR2(20),
  launchYr INTEGER);

CREATE TABLE Battles (
  battleName VARCHAR2(20),
  battleYr INTEGER);
  
CREATE TABLE Outcomes (
  ship VARCHAR2(20),
  battle VARCHAR2(20),
  outcome VARCHAR2(10));

INSERT INTO Classes VALUES ('Iowa', 'bb', 'USA', 9, 16, 46000);
INSERT INTO Ships VALUES ('Missouri', 'Iowa', 1944);
INSERT INTO Battles VALUES ('Surigao Strait', 1944);
INSERT INTO Outcomes (ship, battle, outcome) VALUES ('Missouri', 'Surigao Strait', 'ok');

-- a)
-- INSERT INTO Classes (className) VALUES ('Iowa');

-- b)
-- INSERT INTO Ships (shipName) VALUES ('Missouri');

-- c)
/* DELETE FROM Classes; */

-- d)
-- INSERT INTO Classes(className, typeClass) VALUES ('Kongo', 'aa');

-- e)
-- INSERT INTO Battles(battleName) VALUES ('Surigao Strait');

-- f)
-- INSERT INTO Outcomes (ship, battle) VALUES ('Missouri', 'Surigao Strait');

-- g)
/* DELETE FROM Ships;
SELECT * FROM Outcomes; */

-- h)
/* DELETE FROM Battles;
SELECT * FROM Outcomes; */

-- i)
/* INSERT INTO Ships VALUES ('Wisonsin', 'Iowa', 1944); -- first insert one more ship
INSERT INTO Outcomes VALUES ('Wisconsin', 'Surigao Strait', 'unknown'); -- error) */
