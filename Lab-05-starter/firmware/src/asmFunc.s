/*** asmFunc.s   ***/
/* Tell the assembler to allow both 16b and 32b extended Thumb instructions */
.syntax unified

#include <xc.h>

/* Tell the assembler that what follows is in data memory    */
.data
.align
@ Define the globals so that the C code can access them
/* define and initialize global variables that C can access */
/* create a string */
.global nameStr
.type nameStr,%gnu_unique_object
    
/*** STUDENTS: Change the next line to your name!  **/
nameStr: .asciz "Ian Moser"  

.align   /* realign so that next mem allocations are on word boundaries */
 
/* initialize a global variable that C can access to print the nameStr */
.global nameStrPtr
.type nameStrPtr,%gnu_unique_object
nameStrPtr: .word nameStr   /* Assign the mem loc of nameStr to nameStrPtr */
 
/* define and initialize global variables that C can access */

.global dividend,divisor,quotient,mod,we_have_a_problem
.type dividend,%gnu_unique_object
.type divisor,%gnu_unique_object
.type quotient,%gnu_unique_object
.type mod,%gnu_unique_object
.type we_have_a_problem,%gnu_unique_object

/* NOTE! These are only initialized ONCE, right before the program runs.
 * If you want these to be 0 every time asmFunc gets called, you must set
 * them to 0 at the start of your code!
 */
dividend:          .word     0  
divisor:           .word     0  
quotient:          .word     0  
mod:               .word     0 
we_have_a_problem: .word     0

 /* Tell the assembler that what follows is in instruction memory    */
.text
.align

    
/********************************************************************
function name: asmFunc
function description:
     output = asmFunc ()
     
where:
     output: 
     
     function description: The C call ..........
     
     notes:
        None
          
********************************************************************/    
.global asmFunc
.type asmFunc,%function
asmFunc:   

    /* save the caller's registers, as required by the ARM calling convention */
    push {r4-r11,LR}
 
.if 0
    /* profs test code. */
    mov r0,r0
.endif
    
    /** note to profs: asmFunc.s solution is in Canvas at:
     *    Canvas Files->
     *        Lab Files and Coding Examples->
     *            Lab 5 Division
     * Use it to test the C test code */
    
    /*** STUDENTS: Place your code BELOW this line!!! **************/

    LDR r2, =dividend
    STR r0, [r2]
    LDR r2, =divisor
    STR r1, [r2]
    /*This quickly places the dividend and divisor into memory*/
    MOV r3, 0
    LDR r2, =quotient
    STR r3, [r2]
    LDR r2, =mod
    STR r3, [r2]
    LDR r2, =we_have_a_problem
    STR r3, [r2]
    /*making sure quotient, mod, and we have a problem are at 0*/
    
    CMP r0, r3
    BEQ uhOh
    CMP r1, r3
    BEQ uhOh
    
    MOV r4, 0
    /* I will tick r4 up each time I subtract to be my quotient*/
    
    CMP r0, r1
    BLT finalize
    /* In case the initial number is too small to divide. */
    
divLoop:
    SUBS r0, r1
    BCC uhOh
    ADD r4, 1
    CMP r0, r1
    BGT divLoop
    BEQ divLoop
    BLT finalize

    /* Division by subtraction, and quotient tracking by adding to R4,
     stopping  along the way to make sure we won't hit an error if we
     continue to divide.*/
    
finalize:
    LDR r2, =quotient
    STR r4, [r2]
    
    LDR r2, =mod
    STR r0, [r2]
    /* Storing relevant math results in their addresses. */
    
    LDR r2, =we_have_a_problem
    STR r3, [r2]
    MOV r0, r4
    
    B done
    
    
uhOh:
    LDR r2, =we_have_a_problem
    MOV r5, 1
    STR r5, [r2]
    LDR r0, =quotient
    B done
    /*ticks the flag for having a problem, and fills r0 with the address for
     quotient.*/
    
    /*** STUDENTS: Place your code ABOVE this line!!! **************/

done:    
    /* restore the caller's registers, as required by the 
     * ARM calling convention 
     */
    mov r0,r0 /* these are do-nothing lines to deal with IDE mem display bug */
    mov r0,r0 /* this is a do-nothing line to deal with IDE mem display bug */

screen_shot:    pop {r4-r11,LR}

    mov pc, lr	 /* asmFunc return to caller */
   

/**********************************************************************/   
.end  /* The assembler will not process anything after this directive!!! */
           




