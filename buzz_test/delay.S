#include <avr/io.h>
        .section        .text
        .global         delay
delay:
        mov         r16, r20        ;r20 holds distance value
1:
        mov         r17, r20 	    ;r20 holds distance value
2:      
        ldi         r18, 5          ;locked in at 5      
3:
        dec         r18
        brne        3b   
        dec         r17
        brne        2b                          
        dec         r16
        brne        1b            
        ret





