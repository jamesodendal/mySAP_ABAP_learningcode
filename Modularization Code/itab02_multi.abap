
FORM itab02_milti.
     TABLES       p_itab02 STRUCTURE < itab02 > "#local#"
                  < "Insert correct name for < ... >"
      USING       p_z_field1,
                  p_z_field2.   
    

* Declaration of variables within the subroutine code inside the FORM ENDFORM statements
* FORM can access global variables
* Local variable can only be access in the subroutine they have been declared

ENDFORM.              " itab02_multi