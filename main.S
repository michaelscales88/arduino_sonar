; main.S - Mega kernel testing

#include "config.h"

    .section    .text
    .org        0x00

    .global     main
    .extern     setup
    .extern     main_loop

main:
    ; stack is set up by linker
    call        setup                   ; configure the output pins
    call        main_loop               ; stay inside the main_loop
1:  rjmp        1b                      ; if we exit main_loop we stay here
