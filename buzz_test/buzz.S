#include "config.inc"
        .section .text
        .global     main
        .extern     delay 
        .org        0x0000

main:
        ; set up the stack
        ldi         r28, (RAMEND & 0x00ff)
        ldi         r29, (RAMEND >> 8)
        out         _SPH, r29
        out         _SPL, r28

        ; initilaize the buzzer
        call        init 

;-------------------------------------------------
	; Experimenting...
	; r20 holds value to alter frequency
	; value of 180 = tick tick (max distance)
	; value of 10  = ~4300Hz   (min distance)
	; Create formula to load r20 within these ranges based on sonar input?
	ldi	    r20, 10
;-------------------------------------------------

loop: 
	call	    toggle
	call	    delay
	rjmp	    loop
	
init:   eor         r1, r1                  ; zero out the r1 register
        out         _SREG, r1               ; initialize the status reg
        ldi         r24, 0x80
        sts         CLKPR, r24              ; allow access to clock setup
        sts         CLKPR, r1               ; run at full speed
        
        ; set up the buzz port
        sbi         BUZZ_DIR, BUZZ_PIN        ; set buzz pin to output
        cbi         BUZZ_PORT, BUZZ_PIN       ; start with the buzzer off
        ret

toggle:
        in          r24, BUZZ_PORT           ; get current bits
        ldi         r25, (1 << BUZZ_PIN)     ; buzzer is pin 5
        eor         r24, r25                ; flip the bit
        out         BUZZ_PORT, r24           ; write the bits back
        ret
