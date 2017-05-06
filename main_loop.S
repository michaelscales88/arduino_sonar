; main_loop.S - primary program loop

#include "config.h"

    .section    .text
    .global     main_loop
;    .extern     buzz

main_loop:
1:
;   need to configure out trigger -> likely the clock
    ; lds         r16, trigger
    ; cpi         r16, 1
    ; brne        1b

    ; give all tasks a chance to run
;    check the sonar
;    check the light
;    check the buzzer

    ; reset the trigger variable
    ; sts         trigger, r1
    rjmp        main_loop
