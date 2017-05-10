; timer.S

#include "config.inc"

.equ	COUNT,  250         			; interrupts per trigger event

    	.section    .data
trigger:
    	.byte       0

    	.section    .text
	.global     timer1_init
	.global     TIMER1_COMPA_vect
	.global     trigger

timer1_init:
	lds     r16, TCCR1B
    	ori     r16, (1<<WGM12)|(1<<CS12)|(1<<CS10)	; divide by 1024
    	sts     TCCR1B, r16				; set timer clock
    	ldi     r16, (COUNT & 0xff)			; set in compare count
    	sts     OCR1AL, r16
    	ldi     r16, (COUNT >> 8)
    	sts     OCR1AH, r16
    	lds     r16, TIMSK1				; get interrupt mask reg
    	ori     r16, (1<<OCIE1A)			; enable interrupt
    	sts     TIMSK1, r16				; write it back
    	sei						; let the fun begin
    	ret

; timer 1 compare match interrupt service routine
TIMER1_COMPA_vect:
        ; save callers registers
        push    r16
        push    r0
        in      r0, _SREG				; get flags
        push    r0
        ;
        ldi     r16, 1
        sts     trigger, r16
        ;
        pop     r0
        out     _SREG, r0				; recover flags
        pop     r0
        pop     r16
        reti
