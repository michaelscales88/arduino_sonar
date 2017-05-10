; clock.S - configure the processor clock
#include "config.inc"

    .section .text
    .global clock_init

clock_init:
    ldi     r16, 0x80
    ldi     r17, 2          ; divide by 4
    sts     CLKPR, r16
    sts     CLKPR, r17      ; set speed (4MHz)
    ret
