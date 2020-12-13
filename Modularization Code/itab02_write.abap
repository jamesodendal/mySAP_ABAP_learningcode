
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