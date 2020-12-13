

* INCLUDE statement: This is a programm attribute (/nSE38) create attribute use TYPE >> INCLUDE PROGRAM
* INCLUDE statement can be added using forward navigation (double click the statement) Z_EMPLOYEE_DEFINITIONS 
* INCLUDES are important 

INCLUDE Z_EMPLOYEES_DEFINITIONS.


TABLES: zemployees.


* Table Type bases on Line Type line01_typ
TYPE itab01_typ TYPE STANDARD TYPE OF line01_typ.

* Declare the table based on 'Table Type'

* Now we need to write the code to create the internal table, code about only defines the TYPE.
DATA itab02 TYPE itab01_typ.

* Declare the work area(wa_) to use with Internal Table
DATA wa_itab02 TYPE line01_typ.

DATA line_cnt TYPE i. 

DATA z_field1 LIKE zemployees-surname.

DATA z_field2 LIKE zemployees-forname.


************************ LOGIC PERFORM STATEMENTS

* PERFORM statement is used to create a subroutine
* This will automatically after doing a forward navigation on the itab02_fill create the FORM code 
* this FORM and ENDFORM will include code that is part of a subroutine that can be reused on the program. 

PERFORM itab02_fill.

* Sub routine called by external programs
* PERFORM sub_1 IN PROGRAM zemployee_hire USING z_field1 z_field2.
* Another method for calling external  using the perform method but it cannot be used in Objects
* PERFORM sub_1(zemployee_hire) TABLES itab02 USING z_field1 z_field2.

z_field1 = 'ANDREWS'.

z_field2 = 'BARKER'.

* After the itab02_fill is completed the program will automatically move the the loop code below.

PERFORM itab02_fill_gain USING z_field1 z_field2.

PERFORM itab02_write TABLES itab02.

PERFORM itab02_multi TABLES itab02 USING z_field1 z_field2.



************************ END PERFORM STATEMENTS


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



* This subroutine procedure comes from the line of code #32 and is created via forward navigation of subroutine itab02_fill.abap
* This is an automatic insert if done on the SAP Developer Enivorment but here for my notes its writen like this. 

FORM itab02_fill. 

* Declaration of variables within the subroutine code inside the FORM ENDFORM statements
* FORM can access global variables
* Local variable can only be access in the subroutine they have been declared

DATA zemployees LIKE zemployees-surname.

SELECT * FROM zemployees
  INTO CORRESPONDING FIELDS OF TABLE itab02.

ENDFORM.              " itab02_fill



* This subroutine procedure comes from the line of code #41 and is created via forward navigation of subroutine itab02_fill.abap
* This is an automatic insert if done on the SAP Developer Enivorment but here for my notes its writen like this. 

FORM itab02_fill_again. 
    USING p_zsurname,
          p_zforname.

    WRITE / p_zsurname.
    WRITE / p_zforname.

    p_zsurname = 'abcdef'

* Declaration of variables within the subroutine code inside the FORM ENDFORM statements
* FORM can access global variables
* Local variable can only be access in the subroutine they have been declared


ENDFORM.              " itab02_fill_again



* This subroutine procedure comes from the line of code #47 and is created via forward navigation of subroutine itab02_fill.abap
* This is an automatic insert if done on the SAP Developer Enivorment but here for my notes its writen like this. 

FORM itab02_write.
     TABLES p_itab02 STRUCTURE. 
    

* Declaration of variables within the subroutine code inside the FORM ENDFORM statements
* FORM can access global variables
* Local variable can only be access in the subroutine they have been declared

DATA wa_tmp TYPE line01_typ.

LOOP AT p_itab02 INTO wa_tmp.
  WRITE / wa_tmp-surname.
ENDLOOP.


ENDFORM.              " itab02_write


* This subroutine procedure comes from the line of code #49 and is created via forward navigation of subroutine itab02_fill.abap
* This is an automatic insert if done on the SAP Developer Enivorment but here for my notes its writen like this. 

FORM itab02_milti.
     TABLES       p_itab02 STRUCTURE < itab02 > "#local#"
                  < "Insert correct name for < ... >"
      USING       p_z_field1,
                  p_z_field2.   
    

* Declaration of variables within the subroutine code inside the FORM ENDFORM statements
* FORM can access global variables
* Local variable can only be access in the subroutine they have been declared

ENDFORM.              " itab02_multi




