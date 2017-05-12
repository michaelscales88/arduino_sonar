; signal_task.S - setup and control for trigger and echo
; the HC-SR04!!!

; Matthew Wiederaenders

; from http://www.ezdenki.com/ultrasonic.php :
; Basic Distance Calculation for Ultrasonic Sensing

; The speed of sound: 340.29 m/s (meters per second).
; The speed of sound to an object and back: 170.15 m/s.

; Converting from m/s to µs/cm:
;           s        m     1x106µs   58.772µs
;        ------- X ----- X ------- = --------
;        170.15m   100cm      s         cm

; Time for pulse to travel 1cm and return at 1 MHz: 58.772µs.

; per clock.S, we're running at 4 MHz
; 4 MHz (or 4 M clk/s) =
; 4 clk/us
; 4 clk/us * 58.772us/cm = 235 clk/cm

; # of clicks from start of echo going to high and then starting increment cm
; so, 235 at 4 MHz= 3(x) + 7, x = 76

#include "config.inc"

.equ	one_cm,	76

; wait subroutine takes 3x + 1 clks per iteration
.equ	delay2,	3			; 8 clk takes 2 us at 4 MHz
					; 8 = 3x + 1, x = 2.3, so 3
.equ	delay10,13			; 40 clk takes 10 us at 4 MHz
					; 40 = 3x + 1, x = 13

.section .data
cm:					; reserve 8 bytes for cm distance
	.byte	8

.section .text
    	.global	signal_init		; make signal_init global
    	.global	signal_task		; make signal_task global
	.global	cm			; need cm in led task and buzz task

signal_init:
	sbi	SIGNAL_DIR, TRIG	; set trigger pin to output
	cbi	SIGNAL_DIR, ECHO	; set echo to input

	sbi	SIGNAL_DIR, T0		; set T0 led to output
	cbi	SIGNAL_PORT, T0		; turn off led

    	ret

; data sheet for HC-SR04 call for the trigger to be on low, set to high
; for 10us, then set to low again, the echo pin will be set to high as soon as
; the trigger pin goes to low again, and stays high until
signal_task:

	cbi	SIGNAL_PORT, ECHO	; clear echo for good measure

	cbi	SIGNAL_PORT, TRIG	; set trigger low
	ldi	r17, delay2		; set r17 to delay2, for 2 clks(2 us)
	call	wait			; wait 2us

	sbi	SIGNAL_PORT, TRIG	; set high
	ldi	r17, delay10		; set r17 to delay10, for 10 clks(10 us)
	call	wait			; wait 10us

	cbi	SIGNAL_PORT, TRIG	; set back to low

wait_for_echo:
	sbis	SIGNAL_PIN, ECHO	; need to wait for start of echo to start
	rjmp	wait_for_echo		; not set? keep waiting

	sbi	SIGNAL_PORT, T0

get_echo:
	clr	r18			; clear counter
start:
	inc	r18			; increment counter

	tst	r18			; is counter 0?
	breq	done			; if overflow, r18 will be 0, exit

	ldi	r17, one_cm		; load r17 with one_cm value
	call	wait			; wait # clks for one cm

	sbic	SIGNAL_PIN, ECHO	; skip to done if echo clear
	rjmp	start			; repeat if not clear
done:
	sts	cm, r18			; store r18 to cm
    	ret

; wait subroutine the one and only outside branch
wait:
	dec      r17			; dec r17 counter value
	brne     wait			; loop until 0
	ret				; return to calling function
