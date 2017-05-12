; led task
; Matthew Wiederaenders
; COSC 2325!

#include "config.inc"

.equ	MAX_LED_RANGE,	81		; 80 is our max range for the led
.equ	NUM_LED, 	8		; we have 8 leds	
.equ	DIS_UNIT,	10		; each led will represent ~10cm

#DEFINE r25 = MAX_LED_RANGE		; define r25 as MAX_LED_RANGE
#DEFINE r26 = NUM_LED			; define r26 as NUM_LED
#DEFINE r27 = DIS_UNIT			; define r27 as DIS_UNIT

.section .text
	.global led_init		; we need led_init to be global
					; so we can set LED pins before
					; calling led_task
	.global led_task		; same for led_task
	.extern	cm			; using global variable cm

led_init:
	ldi	r28, 0b11111111 	; set LED pins to input
	out	LED_DIR, r28    	; set direction register

	sbi	SIGNAL_DIR, T1		; set test 1 LED to out
	cbi	SIGNAL_PORT, T1		; clear pin, set to low

	ret

led_task:
	sbi	SIGNAL_PORT, T1		; turn on signal LED 1, verify reach
					; led task
off:
	cbi	LED_PORT, LED0		; clear all distance LEDs to start
	cbi	LED_PORT, LED1
	cbi	LED_PORT, LED2
	cbi	LED_PORT, LED3
	cbi	LED_PORT, LED4
	cbi	LED_PORT, LED5
	cbi	LED_PORT, LED6
	cbi	LED_PORT, LED7

	lds	r16, cm			; load value in cm to r16
	cpi	r16, MAX_LED_RANGE	; r16/cm >= max range?
	brge	done			; done, all stay off
	tst	r16			; cm 0?
	brlt	done			; branch if less than zero

	clr	r28			; clear r28 as counter
led_loop:
	inc	r28			; increment counter
	subi	r16, DIS_UNIT		; subtract distance unit 10 from cm
	tst	r16			; r16 0?
	brlt	set_led			; if less than 0 after subi, set_led
	rjmp	led_loop		; else repeat, since > 0

; checks by comparison all possible counter values such that, for each
; DIS_UNIT of 10 cm, less than 80, greater than 0, that cm is, we light one
; led, if cm < 10 all lit, if cm > 10 but < 20, 7 lit, and so on, cm > 80
; no leds are lit
set_led:
	cpi	r28, 1			; if counter = 1, cm < 10, jmp to 1f
	breq	1f
	cpi	r28, 2			; if counter = 2, cm < 20, jmp to 2f
	breq	2f
	cpi	r28, 3
	breq	3f
	cpi	r28, 4
	breq	4f
	cpi	r28, 5
	breq	5f
	cpi	r28, 6
	breq	6f
	cpi	r28, 7
	breq	7f
	cpi	r28, 8			
	breq	8f

1:	sbi	LED_PORT, LED0		; turn on LED0
2:	sbi	LED_PORT, LED1		; turn on LED1
3:	sbi	LED_PORT, LED2		; and so on...
4:	sbi	LED_PORT, LED3
5:	sbi	LED_PORT, LED4
6:	sbi	LED_PORT, LED5
7:	sbi	LED_PORT, LED6
8:	sbi	LED_PORT, LED7

done:					; done
	ret
