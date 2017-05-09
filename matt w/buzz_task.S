#include "config.inc"

.section .text
	.global buzz_init
	.global buzz_task
	.extern	cm

buzz_init:
	sbi         BUZZ_DIR, BUZZ_PIN  
        cbi         BUZZ_PORT, BUZZ_PIN
	ret 

buzz_task:
	;lds	    r22, cm
	;Cannot get any sound out of the buzzer at all. All attempts at making a delay failed

        in          r16, BUZZ_PORT          
        ldi         r21, (1 << BUZZ_PIN)    
        eor         r16, r21                
        out         BUZZ_PORT, r16

done:
	ret
