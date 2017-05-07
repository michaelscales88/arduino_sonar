; clock.S - configure the processor clock
#include "config.inc"

    .section .text
    .global clock_init

clock_init:
    ldi     r16, 0x80
    ldi     r17, 4          ; divide by 16
    sts     CLKPR, r16
    sts     CLKPR, r17      ; set speed (1MHz)
    ret
