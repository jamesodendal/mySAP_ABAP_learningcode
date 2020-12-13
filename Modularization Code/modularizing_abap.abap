

* INCLUDE statement: This is a programm attribute (/nSE38) create attribute use TYPE >> INCLUDE PROGRAM
* INCLUDE statement can be added using forward navigation (double click the statement) Z_EMPLOYEE_DEFINITIONS 

INCLUDE Z_EMPLOYEE_DEFINITIONS.


TABLES: zemployees.

* Declare the Line Type
TYPES:
      BEGIN OF line01_typ,
               title           LIKE  zemployees-title,
               forname         LIKE  zemployees-forname,
               surname         LIKE  zemployees-surname, 
               dob             LIKE  zemployees-dob,
      END OF line01_typ. 


* Table Type bases on Line Type line01_typ
TYPE itab01_typ TYPE STANDARD TYPE OF line01_typ.

* Declare the table based on 'Table Type'

* Now we need to write the code to create the internal table, code about only defines the TYPE.
DATA itab02 TYPE itab01_typ.

* Declare the work area(wa_) to use with Internal Table
DATA wa_itab02 TYPE line01_typ.

DATA line_cnt TYPE i. 



************************ LOGIC

SELECT * FROM zemployees
  INTO CORRESPONDING FIELDS OF TABLE itab02.

LOOP AT itab02 INTO wa_itab02.

  WRITE / wa_itab02-surname.

ENDLOOP.

CLEAR: itab02, wa_itab02.

LOOP at itab02.
  IF wa_itab02-surname = 'ODENDAL'.
     wa_itab02-surname = 'WARREN'
     MODIFY itab02 FROM wa_itab02.
  ENDIF. 
ENDLOOP.


DESCRIBE TABLE itab02 LINE line_cnt.
INSERT wa_itab02 INTO itab02 INDEX line_cnt.

* READ STATEMENT WORK AREA including WITH statement

READ TABLE itab02 INDEX 5 INTO wa_itab02.



READ TABLE itab02 INDEX 5 INTO wa_itab02
  WITH KEY surname = 'Smith'.
