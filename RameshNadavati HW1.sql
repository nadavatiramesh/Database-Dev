
A)
1.	The MYSQL ALTER statement is 
“ALTER TABLE classes add constraint Ramesh primary key(classname);”

2.	INSERT INTO Classes (className) VALUES ('Iowa')

The given statement does not compile and gives an error as below
Error report -
“SQL Error: ORA-00001: unique constraint (RNADAVAT.RAMESH) violated
00001. 00000 -  "unique constraint (%s.%s) violated" “
In this statement, the column ClassName as the primary key for the table and we already have the value ‘Iowa’ in the column ClassName in the table before we executed the above insert statement. According to the definition of the primary key duplicates can’t exist in the primary key. So we can’t once again insert ‘Iowa’ in the column ClassName.
3.	My confidence level is 10/10

B)
1.	The MYSQL ALTER statement is 
“ALTER TABLE ships add constraint Ramesh1 primary key(shipname);”

2.	“INSERT INTO Ships (shipName) VALUES ('Missouri');”
       The given statement does not compile and gives an error as below
      Error report -
“SQL Error: ORA-00001: unique constraint (RNADAVAT.RAMESH) violated
00001. 00000 -  "unique constraint (%s.%s) violated"”
In this statement the column shipName as the primary key for the table and we already have the value ‘Missouri’ in the column shipName in the table before we executed the above insert statement. According to the definition of the primary key duplicates can’t exist in the primary key. So we can’t once again insert ‘Missouri’ in the column shipName.
3.	My confidence level is 10/10.

C)
1.	The ALTER statement is

 “ALTER TABLE ships add constraint Ramesh3 foreign key (shipClass) references classes(className) on delete cascade;”

2.	“DELETE FROM Classes;”

When we delete the classes table then the corresponding rows in the ships table gets deleted as we used on delete cascade.

3.	My confidence level is 10/10.

D)
1.	The ALTER statement is
“ALTER TABLE classes add constraint Ramesh4 check(typeclass='bb' or typeclass='bc');”
2.	“INSERT INTO Classes(className, typeClass) VALUES ('Kongo', 'aa');”

The given statement does not compile and gives an error as below

Error report -
“SQL Error: ORA-02290: check constraint (RNADAVAT.RAMESH4) violated
02290. 00000 -  "check constraint (%s.%s) violated"”

According to the check constraint we applied on the classes table the typeclass must be either ’bb’ or ‘bc’. In the insert statement we were trying to insert the value instead of the constraint condition i.e. ‘aa’. Because of that we got error. 

3.	My confidence level is 10/10.
E)
1.	The ALTER statement is 

“ALTER TABLE Battles add constraint Ramesh5 primary key(BattleName);”

2.	“INSERT INTO Battles(battleName) VALUES ('Surigao Strait');”

The given statement does not compile and gives an error as like below

Error report -
“SQL Error: ORA-00001: unique constraint (RNADAVAT.RAMESH5) violated
00001. 00000 -  "unique constraint (%s.%s) violated"”
Here, we made the column BattleName as the primary key for the table and we already have the value ‘Surigao Strait’ in the column BattleName in the table before we executed the above insert statement. According to the definition of the primary key duplicates can’t exist in the primary key. So we can’t once again insert ‘Surigao Strait’ in the column BattleName. As like we did at A
3.	My confidence level is 10/10.

F)
1.	The ALTER statement is 

“ALTER TABLE Outcomes ADD CONSTRAINT Rames5 PRIMARY KEY (ship,battle);”

2.	“INSERT INTO Outcomes (ship, battle) VALUES ('Missouri', 'Surigao Strait');”

The given statement does not compile and gives an error as below

Error report -
“SQL Error: ORA-00001: unique constraint (RNADAVAT.RAMES5) violated
00001. 00000 -  "unique constraint (%s.%s) violated"”
Here, We made the columns (ships,battle) as the primary key for the table and we already have the value ‘Missouri,Surigao Strait’ in the columns ship,battle respectively in the table before we executed the above insert statement. According to the definition of the primary key duplicates can’t exist in the primary key. So we can’t once again insert ‘Missouri,Surigao Strait’ in the columns ship,battle respectively.
3.	My confidence level is 10/10.




G)
1.	The ALTER statement is 

“ALTER TABLE Outcomes add constraint NRamesh10 foreign key (ship) references Ships(shipName);”

2.	“DELETE FROM Ships;”

  If the above statement is executed the following error appears 

Error report -
“SQL Error: ORA-02292: integrity constraint (RNADAVAT.NRAMESH10) violated - child record found
02292. 00000 - "integrity constraint (%s.%s) violated - child record found"”

Here we are relating the two tables Outcomes and Ships. We are not using ON DELETE CASCADE. So when we tried to delete the parent table it gave us an error asking us to first delete the tuple of the child table.

3.	My confidence level is 10/10.

H)
1.	The ALTER statement is 

“ALTER TABLE Outcomes add constraint ramesh15 foreign key (Battle) references Battles (battleName) on delete cascade;”

2.	“DELETE FROM Battles;”

Here, when we delete the Battles table then the corresponding rows in the Outcomes table gets deleted as we used on delete cascade.

3.	My confidence level is 10/10.





I)
1.	The ALTER statement is
“ALTER TABLE Outcomes add constraint Ramesh7 check(outcome='sunk' or outcome ='ok' or outcome=’damaged’);”
2.	“INSERT INTO Ships VALUES ('Wisonsin', 'Iowa', 1944);”

It inserts a row in Ships table and it doesn’t break the primary key definition.

3.	“INSERT INTO Outcomes VALUES ('Wisconsin', 'Surigao Strait', 'unknown');”

The given statement does not compile and gives an error as like below
Error report -
SQL Error: ORA-02290: check constraint (RNADAVAT.RAMESH7) violated
02290. 00000 -  "check constraint (%s.%s) violated"
Coming to the explanation, According to the check constraint we applied on the Outcomes table the outcome must be either ’sunk’ or ‘ok’ or ‘damaged’. In the insert statement we were trying to insert the value other than the constraint condition i.e. ‘unknown’. Hence it throws us an error.
4.	My confidence level is 10/10.
