CREATE TABLE Sailors (sid INT PRIMARY KEY, sname VARCHAR(20), rating INT, age NUMBER(3, 1));

CREATE TABLE Reserves (sid INT, bid INT, day DATE, CONSTRAINT reservesPK PRIMARY KEY (sid, bid, day));

INSERT INTO Sailors VALUES (22, 'dustin', 7, 45.0);
INSERT INTO Sailors VALUES (31, 'lubber', 8, 55.5);
INSERT INTO Sailors VALUES (58, 'rusty', 10, 35.0);

INSERT INTO Reserves VALUES (22, 101, TO_DATE('10/10/96', 'MM/DD/YY'));
INSERT INTO Reserves VALUES (58, 103, TO_DATE('11/12/96', 'MM/DD/YY'));