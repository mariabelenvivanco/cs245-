/* Author: Richard Eisenberg
   File: sum.h.cc

   Adds 3 numbers together.
*/
#define __STRING(x) #x
#include <HERA.h>
#include <HERA-print.h>

void HERA_main()
{
  // Memory place for operands in program
    DLABEL(numbers)
      INTEGER(3)
      INTEGER(4)
    CBON() // * disable carrying

    SET(R1, numbers) // * R1 now points to the operands
    LOAD(R2, 0, R1) // * load first operand into R2
    LOAD(R3, 1, R1) // * load second operand into R3

    SET(R4, 0) // * R4 = 0
    LABEL(loop_begin)
    ADD(R0, R3, R0) // * examine R3
    BZR(loop_end) // * if R3 is 0, goto loop_end

    ADD(R4, R2, R4) // * R4 = R2 + R4
    DEC(R3, 1) // * R3 -= 1
    BRR(loop_begin) // * goto loop_begin

    LABEL(loop_end)
    print_reg(R4) // The result is in R4
    HALT()

}
