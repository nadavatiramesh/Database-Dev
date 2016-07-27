/*
  HW4. Due: Mar 11, midnight.

  Construct the database schema, insert the rows and write SQL queries for the problems given. The results that you should be getting for these queries are given to you for verifying your queries.
  If your query does not compile (there is an error in your SQL statement), you must mention that.
  Also if your query generates a different result than given, you must again mention that. (Note that the order of the result rows are insignificant, unless there is an ORDER BY clause).
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
1. Insert three Italian battleships belonging to the class "Veneto" (as these are battleships, the typeClass = 'bb'). Two ships, called "Veneto" and "Italia" are launched in  1940. 
A third ship called "Sicily" is launched in 1941. This class of ships has eight 16-inch guns and a displacement of 41,000 tons. (Note: You have to insert 1 row into the Classes table and 3 rows into the 
Ships table). After you test the inserts, you can issue a rollback statement to rollback the changes made. (If you have difficulty rolling back, you can always drop the tables and create them again). [1 pt]
*/


/*
2. Delete the class North Carolina. Note that before we delete the row from the Classes table, we need to delete the rows in the Ships table that refer to this class. Before deleting from the 
Ships table, we need to delete the rows from Outcomes table that refer to these ships.
Again, issue a rollback so that the changes made by these delete statements are rolled back. [2 pts]
*/

-- Here, we will delete 3 rows from Outcomes, 2 rows from Ships, and 1 row from Classes.

/*
3. Modify the Classes relation so that gun bores are measured in centimeters (and not inches; 1 inch = 2.5 centimeters), and the displacements are measured in metric tons (1 metric ton = 1.1 tons)
Verify the Classes table before the update and after the update to ensure that the data is updated. [1 pt]
*/

/*
4. Define a view that gives for each ship built in the USA (i.e., that class of ships is built in the USA), the name of the ship, the name of the class, the number of guns, the bore and displacement. [1 pt]
*/

/* Results when we execute: SELECT * FROM USAShips
SHIPNAME             CLASSNAME               NUMGUNS       BORE DISPLACEMENT
-------------------- -------------------- ---------- ---------- ------------
California           Tennessee                    12         14        32000 
Iowa                 Iowa                          9         16        46000 
Missouri             Iowa                          9         16        46000 
New Jersey           Iowa                          9         16        46000 
North Carolina       North Carolina                9         16        37000 
Tennessee            Tennessee                    12         14        32000 
Washington           North Carolina                9         16        37000 
Wisconsin            Iowa                          9         16        46000 
*/

/*
5. Use the view: USAShips to find the USA ship(s) with largest displacement (only among USA ships). Return shipName, className, numGuns, bore and displacement; also order the results by the className. [1 pt]
Note: You MUST use the view defined above.
*/


/* 
SHIPNAME             CLASSNAME               NUMGUNS       BORE DISPLACEMENT
-------------------- -------------------- ---------- ---------- ------------
Iowa                 Iowa                          9         16        46000 
Wisconsin            Iowa                          9         16        46000 
New Jersey           Iowa                          9         16        46000 
Missouri             Iowa                          9         16        46000 
*/

/*
6. Create a table Student with columns as studentId (an integer), a name of a student (VARCHAR(20)), and a major (VARCHAR(20)).
Set the default value for major = 'Undecided' [1 pt]

INSERT INTO Student(studentID, studentName) VALUES (1234, 'Mary');
should insert Mary with major as Undecided
*/


/* Results from SELECT * FROM Student; (after the above insert)
STUDENTID              STUDENTNAME          MAJOR                
---------------------- -------------------- -------------------- 
1234                   Mary                 Undecided         
*/

/* 7: [2 pts]
Write a stored procedure that takes a ship name as input and prints the battles that the ship was involved with. 

Suppose you call the procedure as printBattlesForShip, then you can call the procedure as follows:
SET SERVEROUTPUT ON;
CALL printBattlesForShip('North Carolina');

You should get the following results for the the above call (based on our data) -- do not mind the last , -- you can try to get rid of it if you want to:
printbattlesforship 'NORTH CAROLINA') succeeded.
The battles for ship North Carolina are: Surigao Strait, Guadalcanal,
*/
