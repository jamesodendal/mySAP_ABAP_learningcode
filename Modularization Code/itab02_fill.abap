
FORM itab02_fill. 

SELECT * FROM zemployees
  INTO CORRESPONDING FIELDS OF TABLE itab02.

ENDFORM.              " itab02_filll