; the ultrasonic HC-SR04 AVR assembly
; credit to Mike Shegedin for some ideas

#include "config.h"

	.section .text
    .org 0x00
    .global     main

; function setup
main:
; initialize the pins and registers
	call		Init
    call    	main_loop

; main loop
main_loop:
	; 60ms per total pulse cycle -> outer loop
	eor			r21,	r21					; 60 ms delay for outer loop
	eor			r22,	r22					; counter for distance

	call		Trigger_OFF					; send LOW to the TRIGGER
1:	ldi			r16, 2						;	2 microsecond delay
	dec			r16
	brnz		1b
	call		Trigger_ON					; send HIGH to the TRIGGER -> Start count
2:	ldi			r16, 10						;	10 microsecond delay
	dec			r16
	brnz		2b
	call		Trigger_OFF					; send LOW to the TRIGGER
	ldi			r21, 53						; 60 ms is approx 72000 clks
	.trigger:
	; whenever we fire the trigger HIGH and then LOW the state of the PIND changes according if
	; the ECHO_PIN bit is HIGH or LOW, so all we need is to get the state of the PIND register
	; and according to its state to skip related instructions

;		sbic		SONAR_PORT, ECHO_PIN        ; skip next instruction if the ECHO_PIN bit is LOW
;		cbi	    	LED_PORT, LED_PIN		    ; clear the LED bit in the PORTB register

		sbis		SONAR_PORT, ECHO_PIN		; skip next instruction if the ECHO_PIN bit is HIGH
		jmp			.done
;		sbi	    	LED_PORT, LED_PIN		    ; set the LED bit in the PORTB register
		add			r22		8					; counting cycles
		sub			r21,	8					; checking if 60ms have elapsed
		brnz		.trigger					; loop until 60 ms elapses
	.done:
		; this is where the led light get's toggled for < the right distance
	jmp			main_loop			        ; repeat the loop
	ret

; initializing the I/O
; in DDRx if bit is 1 - the pin is for output and if 0 - the pin is for input
; e.g. the 5th bit controls the 5th pin of the corresponding PORTx
Init:
	sbi			SONAR_DIR, TRIGGER_PIN		; PORTD -> set the trigger pin for output
	cbi	    	SONAR_DIR, ECHO_PIN			; PORTD -> set the ECHO_PIN pin for input
	sbi     	LED_DIR, LED_PIN		    ; set pin 5 on port B for output
	cbi	    	LED_PORT, LED_PIN		    ; turn off the LED
    ret

; the delay of 0.6ms or 10000 cycles on the 16Mhz chip
System_Delay:
	ldi			r17, DELAY					; outer loop
SD_L1:
	ldi			r18, DELAY					; inner loop
SD_L2:
	dec        	r18							; use R17 as a parameter -> decrement it
	brne       	SD_L2						; if not ZERO -> keep decrementing
	dec	       	r17
	brne	   	SD_L1
	ret

; trigger routines
Trigger_ON:
	sbi			SONAR_PORT, TRIGGER_PIN		; set the trigger bit in PORTD HIGH
	ret

Trigger_OFF:
	cbi			SONAR_PORT, TRIGGER_PIN		; set the trigger bit in PORTD LOW
	ret

toggle:
    in          r24, LED_PORT           ; get current bits
    ldi         r25, (1 << LED_PIN)     ; LED is pin 5
    eor         r24, r25                ; flip the bit
    out         LED_PORT, r24           ; write the bits back
    ret
