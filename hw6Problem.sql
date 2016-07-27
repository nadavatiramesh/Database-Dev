/*
  HW6. Due: Apr 01 (midnight).
  Construct the database schema, insert the rows and write PL/SQL statements for the problems given. The results that you should be getting for these statements are given to you for verifying your PL/SQL statements.
  If your PL/SQL statement does not compile (there is an error in your statement), you MUST mention that.
  Also if your PL/SQL statement generates a different result than given, you must again mention that. (Note that the order of the result rows are insignificant, unless there is an ORDER BY clause).
  For each problem, indicate your confidence level on a scale from 0 .. 10, with 0 indicating the lowest level of confidence, and 10 indicating the highest level of confidence. 
*/

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

/*

You may also want to use the following PL/SQL script to drop all objects in your database. I got this script from:
http://www.dbasupport.com/forums/showthread.php?48689-script-to-drop-all-user-objects

SET SERVEROUTPUT ON SIZE 1000000
BEGIN
  FOR cur_rec IN (SELECT object_name, object_type 
                  FROM   user_objects
                  WHERE  object_type IN ('TABLE', 'VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE')) LOOP
    BEGIN
      IF cur_rec.object_type = 'TABLE' THEN
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
      ELSE
        EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
    END;
  END LOOP;
end;
/

*/

/* Problem 1. [2 pts]
Write one or two triggers to handle the following:
When a class is updated with a displacement greater than 35000 tons, allow the update, but change the displacement to 35000. 
When a class is inserted with a displacement greater than 35000 tons, allow the insert, but change the displacement to 35000. 
Hint: Use a BEFORE UPDATE trigger and BEFORE INSERT trigger. You can combine the two into one trigger as: BEFORE UPDATE OR INSERT trigger.

Code for testing your triggers:

SELECT * FROM Classes WHERE className = 'Tennessee';
UPDATE Classes SET displacement = 36000 WHERE className = 'Tennessee';
SELECT * FROM Classes WHERE className = 'Tennessee';
rollback;

INSERT INTO Classes (className, displacement) VALUES ('myClass', 40000);
SELECT * FROM Classes WHERE className = 'myClass';
rollback;

*/

/* Problem 2: [2 pts]

Write a trigger such that when a row is inserted into outcomes or when a row in outcomes is updated, we check the corresponding battle and ship years.
The idea is: it is not meaningful to have a ship launch year be after the year a battle in which the ship participated.
How will we achieve it: We will write 1 or more triggers that ensure for insert and update into outcomes, if the ship launch year is > battle year, we will update the ship launch year to be = the battle year.

Code for testing: 

SELECT * FROM Ships WHERE shipName = 'Missouri';
INSERT INTO Outcomes(ship, battle, outcome) VALUES ('Missouri', 'Guadalcanal', 'ok');
SELECT * FROM Ships WHERE shipName = 'Missouri';
rollback;


INSERT INTO Ships(shipName, launchYr) VALUES ('myShip', 1945);
SELECT * FROM Ships WHERE shipName = 'myShip';
INSERT INTO Outcomes (ship, battle, outcome) VALUES ('myShip', 'Guadalcanal', 'ok');
SELECT * FROM Ships WHERE shipName = 'myShip';
rollback;

*/

/* Problem 3. [2 pts]

We will write triggers to simulate "insert cascade" (remember: Oracle allows specification of only DELETE CASCADE as part of foreign keys).

In our application, we have foreign key from Ships referencing Classes.
We will write a trigger so that when we insert into a Ship and the class does not exist in the Classes table, we will insert a row into the Classes table. Therefore the foreign key constraint is satisfied.
In other words, suppose we insert into Ships as:
INSERT INTO Ships(shipName, shipClass) VALUES ('myShip1', 'myClass');

it should result in a row created into Classes table where className = 'myClass' (other values should be default values, which are NULL (as no default values are specified).
it should also result in a row created into Ships table with shipName = 'myShip' and shipClass = 'myClass' -- launchYr should take default value, which is NULL.

note that if the class already exists, then only a row in Ships will be inserted.

Note: You should write a BEFORE INSERT ON Ships trigger to handle this.

Code for testing:
SELECT * FROM Classes WHERE className = 'myClass';
SELECT * FROM Ships WHERE shipClass = 'myClass';
INSERT INTO Ships (shipName, shipClass) VALUES ('myShip1', 'myClass');
SELECT * FROM Classes WHERE className = 'myClass';
SELECT * FROM Ships WHERE shipClass = 'myClass';

INSERT INTO Ships (shipName, shipClass) VALUES ('myShip2', 'myClass'); -- myClass already exists in Classes.
SELECT * FROM Classes WHERE className = 'myClass';
SELECT * FROM Ships WHERE shipClass = 'myClass';
rollback;

*/

/* Problem 4. [2 pts]

Suppose you have a view defined from your previous homework as:

CREATE OR REPLACE FORCE VIEW USAShips AS 
SELECT shipName, className, numGuns, bore
FROM Classes C1, Ships S1
WHERE C1.className = S1.shipClass AND C1.country = 'USA';

Check the following insert will give an error.
INSERT INTO USAShips (shipName, className, numGuns, bore) VALUES ('myShip1', 'myClass', 14, 18);

Write an INSTEAD OF TRIGGER so that when an insert is specified on the view, the trigger will do the following:
Check if there is already a row in Classes with the specified className.
  if such a class is not there, insert such a class specifying the className, numGuns, bore and country = 'USA'
  if such a class is there, then update the class with the specified values (for numGuns, bore, country).
Check if there is already a row in Ships with the specified shipName.
  if such a ship is not there, insert such a ship specifying the shipName and the shipClass
  if such a ship is already there, then update the ship with the specified values (for shipClass)
  
Code for testing:
INSERT INTO USAShips (shipName, className, numGuns, bore) VALUES ('myShip1', 'myClass', 14, 18); 
SELECT * FROM USAShips WHERE className = 'myClass'; -- check insert into Classes and Ships

INSERT INTO USAShips (shipName, className, numGuns, bore) VALUES ('myShip2', 'myClass', 14, 18);
SELECT * FROM USAShips WHERE className = 'myClass'; -- check insert only into Ships

INSERT INTO USAShips (shipName, className, numGuns, bore) VALUES ('myShip3', 'myClass', 16, 19);
SELECT * FROM USAShips WHERE className = 'myClass'; -- see that numGuns, bore of all ships of myClass are updated

INSERT INTO Classes (className, country) VALUES ('myClass2', 'Germany');
SELECT * FROM Classes WHERE className = 'myClass2';
INSERT INTO USAShips(shipName, classname) VALUES ('myShip4', 'myClass2');
SELECT * FROM Classes WHERE className = 'myClass2'; -- see that existing class gets updated

INSERT INTO Classes (className, country) VALUES ('myClass3', 'Germany');
INSERT INTO Ships(shipName, shipClass) VALUES ('myShip5', 'myClass3');
SELECT * FROM Ships WHERE shipName = 'myShip5';
INSERT INTO USAShips(shipName, className) VALUES ('myShip5', 'myClass'); -- see that existing ship gets updated
SELECT * FROM Ships WHERE shipName = 'myShip5';
rollback;

Note: this trigger does fire the previous "insert cascade" trigger for insert into ships. However, it should not affect the functioning in any way.
If you find that the "insert cascade" trigger is interfering with this trigger, then you can drop the "insert cascade trigger".

*/

/* Problem 5. [2 pts]

Goal: Using triggers for logging updates, row and statement level trigger.

Specify a statement level trigger so that whenever any SQL UPDATE statement (note: you need to do this only for UPDATE statements; not INSERT or DELETE statements) is performed on the Ships table, a log record is stored in a table that stores the time when the update happened.
Specify a row level trigger so that whenever any row is updated (again, using a SQL UPDATE statement; and not using INSERT or DELETE statements) in the Ships table, a log record is stored in the same table that stores the time the row update happened.

I called the table that logs the inserts as logTblUpdateShips. To create the table, we can execute the following statements (create 2 columns, one is a description and another is the time of insertion):
DROP TABLE logTblUpdateShips;
CREATE TABLE logTblUpdateShips(info VARCHAR(100), timeInserted DATE);

Let us check how the trigger works. I issue 3 insert statements (note that it is is a statement-level trigger) as follows:
INSERT INTO Classes(className) VALUES ('myClass1');
INSERT INTO Ships(shipName, shipClass) VALUES ('myShip1', 'myClass1');
INSERT INTO Ships(shipName, shipClass) VALUES ('myShip2', 'myClass1');
INSERT INTO Ships(shipName, shipClass) VALUES ('myShip3', 'myClass1');

SELECT info, TO_CHAR(timeInserted, 'DD-MON-YYYY HH:MI:SS') AS timeInserted FROM logTblUpdateShips ORDER BY timeInserted DESC;
UPDATE Ships SET launchYr = 1945 WHERE shipClass = 'myClass1';
SELECT info, TO_CHAR(timeInserted, 'DD-MON-YYYY HH:MI:SS') AS timeInserted FROM logTblUpdateShips ORDER BY timeInserted DESC;

This is the expected result from the last query.
INFO                                                                                                 TIMEINSERTED       
---------------------------------------------------------------------------------------------------- --------------------
update statement performed                                                                           28-OCT-2012 04:01:40 
a row updated                                                                                        28-OCT-2012 04:01:40 
a row updated                                                                                        28-OCT-2012 04:01:40 
a row updated                                                                                        28-OCT-2012 04:01:40 

ROLLBACK; -- to rollback the inserts (it will rollback the log records also).
*/

