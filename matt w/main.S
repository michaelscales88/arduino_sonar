#include "config.inc"

    .section    .text
    .org        0x00

    .global     main
    .extern     setup
    .extern     main_loop

main:
    ; stack is set up by linker
    call        setup            ; configure the output pins
    call        main_loop
