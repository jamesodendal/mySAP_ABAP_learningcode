*** INCLUDE for modularizing_abap.abap program


* Declare the Line Type
TYPES:
      BEGIN OF line01_typ,
               title           LIKE  zemployees-title,
               forname         LIKE  zemployees-forname,
               surname         LIKE  zemployees-surname, 
               dob             LIKE  zemployees-dob,
      END OF line01_typ. 