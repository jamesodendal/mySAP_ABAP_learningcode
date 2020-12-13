


DATA result LIKE SPELL. 

SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN commment 1(15) text-001.

PARAMETER myNum TYPE i.
SELECTION-SCREEN END OF LINE. 

* CALL FUNCTION ---- IMPORTANT TO NOTE WHEN TYPING (CTRL + F6) or PATTERN ---- CALL FUNCITON
* It is posisble to get the call function and here its 'SPELL_AMOUNT'
* What happens then is, when the 'SPELL_AMOUNT' is selected the will appear in screen 
* Now it is ready for use and it is also possible to activate the uncommeneted code based on needs

CALL FUNCTION 'SPELL_AMOUNT'


* If you need to any of the function parameter uncomment it.
* Important it to check the IF sy-subrc <> 0.
* IF sy-subrc != 0, then you have a problem if sy-subrc = 0 good to go! 

    EXPORTING:
      AMOUNT        = myNum
*      CURRENCY      = ''
*      FILLER        = ''
*      LANGUAGE      = SY-LANGU
     IMPORTING
      IN_WORD       = result
*   EXPORTING
*     NOT_FOUND     = 1
*     TOO_LARGE     = 2
*     OTHERS        = 3

IF sy-subrc <> 0.

  WRITE: / 'The function Module returned a value of ', sy-subrc.
ELSE.
  WRITE: / 'The amount in words is:', result-word.

ENDIF. 















