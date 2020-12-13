
FORM itab02_fill_again. 
    USING p_zsurname,
          p_zforname.

    WRITE / p_zsurname.
    WRITE / p_zforname.

    p_zsurname = 'abcdef'

* Declaration of variables within the subroutine code inside the FORM ENDFORM statements
* FORM can access global variables
* Local variable can only be access in the subroutine they have been declared



ENDFORM.              " itab02_filll
