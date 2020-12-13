
* Defining internal tables

* Records using in the table can only be refereded to if you have already created the records.
* itab01 is a general internal table name 

* BEGIN OF means we are starting the definition of 

* OCCURS clause means that we are defining an internal table (general syntax is itabXX, XX = generally the number)
* VALUE after the OCCURS statement is referes to the amount of records in the internal table (itab01) 0 generally means you not sure how much records wiil be in it. 

* The zemployees table I created in previous program code and in creating the internal table below I make reference to this table see zemployees-surname,dob.



* Old way of coding writing Internal table.
*Internal Table with Header line
DATA: 
      BEGIN OF itab01          OCCURS 0,
               title(4)        TYPE   c,
               surname(40)     LIKE   zemployees-surname, 
               dob(6)          LIKE   zemployees-dob,
      END OF itab01. 



* POPULATING INTERNAL TABLES 

* DEFINING NEW TABLE 

* Internal Table with Header line.

DATA: 
      BEGIN OF itab04 OCCURS 0,
        employee      LIKE zemployees-employee,
        surname       LIKE zemployees-surname,
        forname       LIKE zemployees-fornane,
        title         LIKE zemployees-title,
        dob           LIKE zemployees-dob,
        los           TYPE VALUE 3.
      END OF itab04.


* INSERT statement
* Filling the table : SELECT is an array fetch SQL code, FROM the zemployees table created 
* INSERT CORRESPONDING FIELF OF TABLE into04 >>>> This puts the records from the table created itab04.

SELECT * FROM zemployees,

  INTO CORRESPONDING FIELDS OF TABLE itab04. 
ENDSELECT.

* View records after INSERT
WRITE / itab04-surname.



* APPEND statement: This is mainly to move statement into the header record, not ideal solution 

SELECT * FROM zemployees.

  MOVE zemployees-employee TO itab04-employee,
  MOVE zemployees-surname  TO itab04-surname,
  MOVE zemployees-forname  TO itab04-forname,
  MOVE zemployees-title    TO itab04-title,
  MOVE zemployees-dob      TO itab04-dob.

* Append statement moves the data to the body of the of the table
  APPEND itab04.

ENDSELECT. 

WRITE / itab04-surname.


* A more convient way of writing the same code would be to use the following statment MOVE CORRESPONDING:
* Here it is important to make sure that the field correspond due to inconsistancy.

SELECT * FROM zemployees.
  
  MOVE CORRESPONDING zemployees to itab04.

  APPEND itab04.

ENDSELECT.

WRITE / itab04-surname.



* Aonther array fetch methods can be applied to populate data into a table
* Quite affected way to populate tables internal tables
* Statement is much fater than using a loop
* However it will only copy the tables into the intenral table itab04 with corresponding fields

SELECT * FROM zemployees INTO CORRESPONDING FIELDS OF TABLE itab04.

WRITE / itab04-surname.

* Another way is to identify the specific fields you want to use from your source table

SELECT surname forname title dob FROM zemployees INTO CORRESPONDING FIELDS OF TABLE itab04.

WRITE / itab04-surname.




 
* CREATING NEW TABLE INTERNAL TABLE WITH OTHER STATEMTS. 
DATA: 
      BEGIN OF itab05 OCCURS 0.

          INCLUDE STRUCTURE itab04. 

DATA  END OF itab05.

* CREATING NEW TABLE INTERNAL TABLE WITH OTHER STATEMTS. 
DATA: 
      BEGIN OF itab06 OCCURS 0.

          INCLUDE STRUCTURE zemployees. 

DATA  END OF itab06.

* CREATING NEW TABLE INTERNAL TABLE WITH OTHER STATEMTS. 
DATA: 
      BEGIN OF itab07 OCCURS 0.

          INCLUDE STRUCTURE zemployees.
          INCLUDE STRUCTURE itab04. 

DATA  END OF itab07.




TYPES:
      BEGIN OF line01_typ,
               title(4)        TYPE   c,
               forname(40)     TYPE   c,
               surname         LIKE   zemployees-surname, 
               dob             LIKE   zemployees-dob,
      END OF line01_typ. 


* Table Type
TYPE itab01_typ TYPE STANDARD TYPE OF line01_typ.

* Define a SORTED table
TYPE itab01_typ TYPE SORTED TABLE OF line01_typ 
                                 WITH UNIQUE KEY surname dob, forname, title.

* Declare the table based on 'Table Type'

* Now we need to write the code to create the internal table, code about only defines the TYPE.

DATA itab02 TYPE itab02_typ.

* To create a new internal table one can simply use the following code, take not that the ***** itab03 - new table and the reference to TYPE itab02_typ.

DATA itab03 TYPE itab02_typ.


* Defind working area, work area is not part of the table its is working in conjuction with the wa_area data can be moved into wa_table

DATA wa_itab02 TYPE line01_typ. 

SELECT surname dob FROM zemployees 

  INTO wa_itab02.
  APPEND wa_itab02 TO itab02.

ENDSELECT.


* Coding an array fetch
SELECT * FROM zemployees 

  INTO CORRESPONDING FIELDS OF TABLE itab02.

  LOOP at itab02 INTO wa_itab02.

  WRITE / wa_itab02-surname.

  ENDLOOP.



* LOOK AND ENDLOOP statements is used to process the records selected with Headerline Internal table:
* Internal Table with Header line.

DATA: 
      BEGIN OF itab08 OCCURS 0,
        employee      LIKE zemployees-employee,
        surname       LIKE zemployees-surname,
        forname       LIKE zemployees-fornane,
        title         LIKE zemployees-title,
        dob           LIKE zemployees-dob,
        los           TYPE VALUE 3.
      END OF itab08.

DATA line_cnt TYPE i. 

SELECT * FROM zemployees.

  MOVE zemployees-employee TO itab08-employee,
  MOVE zemployees-surname  TO itab08-surname,
  MOVE zemployees-forname  TO itab08-forname,
  MOVE zemployees-title    TO itab08-title,
  MOVE zemployees-dob      TO itab08-dob.

* Append statement moves the data to the body of the of the table
  APPEND itab08.

ENDSELECT. 

LOOP AT itab08. 
  
  WRITE / itab08-surname, itab08-forname.

ENDLOOP.


* UPDATE the records in an internal table 

LOOP AT itab08.
  IF itab08-surname = 'ODENDAL'.
     itab08-surname = 'BOND'.
     MODIFY itab08. "Do not use modify code with UNIQUE KEY"
  ENDIF.

ENDLOOP.

DESCRIBE TABLE itab08 LINE line_cnt. 

INSERT itab08 INDEX line_cnt.

WRITE / itab08-surname.


* READ statement to inspect table contect
* READ statement without UNIQUE-key like internal standard tables needs specific syntax
* READ statements are also used quite often and it is generally faster than other statements. 

READ TABLE itab08 INDEX 5. 

* This is an example using a Key for a specific search
READ TABLE itab08 WITH KEY
  employee = 10000009. 



* DELETE records from INTERNAL TABLES.

DELETE itab08 INDEX 5. 


LOOP AT itab08.
  IF itab08-surname = 'WARREN'.
     DELETE itab08 INDEX sy-index. "System variable automatically gets updated by system "
  ENDIF.

ENDLOOP.

* WHERE addition
DELETE itab08 WHERE surname = 'ODENDAL'. 


* SORT statment internal tables

SORT itab08. 


* SORT statment STANDARD internal tables

SORT itab08 DESCENDING AS TEXT BY surname forname. 



* LOOPING INTO AND MODIFY WORK AREA


SELECT * FROM zemployees
  INTO CORRESPONDING FIELDS OF TABLE itab08.

LOOP AT itab08 INTO wa_itab08.

  WRITE / wa_itab08-surname.

ENDLOOP.

  LOOP at itab08.
   IF wa_itab08-surname = 'ODENDAL'.
     wa_itab08-surname = 'WARREN'
       MODIFY itab08 FROM wa_itab08.
  ENDIF. 
ENDLOOP.


* INSERT INTO WORK AREA

DESCRIBE TABLE itab08 LINES line_cnt.
INSERT wa_itab01 INTO itab08 INDEX line_cnt.



* READ STATEMENT WORK AREA including WITH statement

READ TABLE itab08 INDEX 5 INTO wa_itab08.



READ TABLE itab08 INDEX 5 INTO wa_itab08
   WITH KEY surname = 'Smith'.


* DELETE INTERNAL TABLES
* It is very important to follow specific steps when it comes to Deleting internal tables and recoreds


DATA: 
      BEGIN OF itab09 OCCURS 0,
        employee      LIKE zemployees-employee,
        surname       LIKE zemployees-surname,
        forname       LIKE zemployees-fornane,
        title         LIKE zemployees-title,
        dob           LIKE zemployees-dob,
        los           TYPE VALUE 3.
      END OF itab09.


SELECT * FROM zemployees.

  MOVE zemployees-employee TO itab09-employee,
  MOVE zemployees-surname  TO itab09-surname,
  MOVE zemployees-forname  TO itab09-forname,
  MOVE zemployees-title    TO itab09-title,
  MOVE zemployees-dob      TO itab09-dob.

* Append statement moves the data to the body of the of the table
  APPEND itab09.

ENDSELECT. 

WRITE / itab09-surname.



* This statement will CLEAR the header line only, all fields will be set to its initail value.
CLEAR itab09. "all records will be set to its initail value."

* This statement will CLEAR the body use below syntax
CLEAR itab01[]. "clears all the records in the body will be deleted"

* Refresh statment also clears the records from an internal table, THIS however does not delete the header record for this use CLEAR statement
REFRESH itab09. 

* FREE statement is also quite useful it clear the records from internal table and it also removes memory used by the program
* This does not mean your internal table is gone or does not exists, its emptied out of memory you can call the table again
FREE itab09. 


* DELETING WORK AREA TABLES with HEADER LINES

CLEAR itab09.
CLEAR wa_itab09. " Here I did not create the internal table itab09 but I use it to illustrate the concept"

REFRESH itab09.
CLEAR wa_itab09.

FREE itab09. 
CLEAR wa_itab09. 




















