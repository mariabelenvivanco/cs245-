#define __STRING(x) #x
#include <HERA.h>
#include <HERA-print.h>

//checks if even or odd
void HERA_main()
{
  DLABEL (number)
    INTEGER(2)
    INTEGER(1) // number is odd
    INTEGER(0) // number is even

  CBON()

  SET(R1, number) // sets R1 to first element of number
  SET(R5, 2) //SUBTRACTION
  LOAD(R3, 0, R1) // load value from number[0] in R3

  LABEL(loop_begin)
  SUB(R0, R3, R0) // discard result -> change flag
  BLR(odd)// if zero
  BZR(even)// if negative


  SUB(R3, R3, R5) //R3 - 4
  SUB(R0, R3, R0)
  BGR(loop_begin) // is r3 greater than zero

  LABEL(odd)
  LOAD(R4,1,R1)
  BRR(return)


  LABEL(even)
  LOAD(R4,2,R1)
  BRR(return)

  LABEL(return)
  print_reg(R4) // The result is in R4
  HALT()

}
