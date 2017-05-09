;buzz task

#include "config.inc"

        .section    .text
	.global	    buzz_init
	.global     buzz_task
	.extern	    cm

buzz_init:
	sbi         BUZZ_DIR, BUZZ_PIN  
        cbi         BUZZ_PORT, BUZZ_PIN
	ret 

buzz_task:
	;lds	    r22, cm

	;try loading r16 with cm and observe how the tick rate changes based on sonar
	;~255 = slow tick, ~30 = fastest tick available
	;(not linear)

        ldi         r16, 255  ;temporarily set to 255. varies based on cm    
1:
        ldi         r17, 50   ;locked in @ 50    
2:      
        ldi         r18, 50   ;locked in @ 50   
3:
        dec         r18
        brne        3b              
        dec         r17
        brne        2b               
        dec         r16
        brne        1b               

        in          r16, BUZZ_PORT          
        ldi         r21, (1 << BUZZ_PIN)    
        eor         r16, r21                
        out         BUZZ_PORT, r16
	ret

