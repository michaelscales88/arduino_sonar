; the ultrasonic HC-SR04 AVR assembly
; credit to Mike Shegedin for some ideas

#include "config.h"

	.section .text
    .org 0x00
    .global     main

; function setup
main:
	; ; set stack to top of available ram
    ; ldi 	r28, (RAMEND & 0x00ff)
 ;   	ldi 	r29, (RAMEND >> 8)
 ;   	out 	SPH, r29
 ;   	out 	SPL, r28

; initialize the pins and registers
	call	Init
    call    main_loop


; main loop
main_loop:
	call	Trigger_ON			; send HIGH to the TRIGGER
	call	System_Delay			; wait for 0.6ms

	call	Trigger_OFF			; send LOW to the TRIGGER
	call	System_Delay			; wait for 0.6ms

; whenever we fire the trigger HIGH and then LOW the state of the PIND changes according if
; the ECHO_PIN bit is HIGH or LOW, so all we need is to get the state of the PIND register
; and according to its state to skip related instructions

	sbic	PIND, ECHO_PIN            ; skip next instruction if the ECHO_PIN bit in PIND is LOW
	cbi	    LED_PORT, LED_PIN		    ; clear the LED bit in the PORTB register

	sbis	PIND, ECHO_PIN			     ; skip next instruction if the ECHO_PIN bit in PIND is HIGH
	sbi	    LED_PORT, LED_PIN		    ; set the LED bit in the PORTB register

	call	System_Delay			   ; another 0.6ms delay
    rjmp	main_loop			        ; repeat the loop
	ret

; initializing the I/O
; in DDRx if bit is 1 - the pin is for output and if 0 - the pin is for input
; e.g. the 5th bit controls the 5th pin of the corresponding PORTx
Init:
	sbi	   TRIGGER_DIR, TRIGGER_PIN		; PORTD -> set the trigger pin for output
	cbi	   TRIGGER_DIR, ECHO_PIN		; PORTD -> set the ECHO_PIN pin for input
	sbi    LED_DIR, LED_PIN		        ; set pin 5 on port B for output
	cbi	   LED_PORT, LED_PIN		    ; turn off the LED
    ret

; the delay of 0.6ms or 10000 cycles on the 16Mhz chip
System_Delay:
	ldi	r17, DELAY		; outer loop
SD_L1:
	ldi	r18, DELAY		; inner loop
SD_L2:
	dec        r18			; use R17 as a parameter -> decrement it
	brne       SD_L2			; if not ZERO -> keep decrementing
	dec	       r17
	brne	   SD_L1
	ret

; trigger routines
Trigger_ON:
	sbi	TRIGGER_PORT, TRIGGER_PIN		; set the trigger bit in PORTD HIGH
	ret

Trigger_OFF:				; set the trigger bit in PORTD LOW
	cbi	TRIGGER_PORT, TRIGGER_PIN
	ret
