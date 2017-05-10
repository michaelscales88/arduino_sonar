;buzz task

#include "config.inc"

        .section    .text
	.global	    buzz_init
	.global     buzz_task
	.extern	    cm

buzz_init:
	; buzz setup
	sbi         BUZZ_DIR, BUZZ_PIN
    	cbi         BUZZ_PORT, BUZZ_PIN
	ret

buzz_task:
    	lds         r16, cm   ;outer loop varies based on cm(distance)
1:
    	ldi         r17, 50   ;locked in @ 50
2:
    	ldi         r18, 50   ;locked in @ 50
3:
	;begin decrements
    	dec         r18
    	brne        3b
    	dec         r17
    	brne        2b
    	dec         r16
    	brne        1b

	; activate buzzer
    	in          r16, BUZZ_PORT	
    	ldi         r21, (1 << BUZZ_PIN)
    	eor         r16, r21
    	out         BUZZ_PORT, r16
	ret
