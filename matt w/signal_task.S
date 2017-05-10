; signal_task.S - setup and control for trigger and echo
; the HC-SR04!!!

; from http://www.ezdenki.com/ultrasonic.php :
; Basic Distance Calculation for Ultrasonic Sensing
; The speed of sound: 340.29 m/s (meters per second).
; The speed of sound to an object and back: 170.15 m/s.
; Converting from m/s to µs/cm:
;           s        m     1x106µs   58.772µs
;        ------- X ----- X ------- = --------
;        170.15m   100cm      s         cm
; Time for pulse to travel 1cm and return: 58.772µs.

; per clock.S, we're running at 1MHz
; 1 MHz (or 1 M clk/s) =
; 1 clk/us
; 1 clk/us * 58.772us/cm = 58.772clk/cm

; # of clicks from start of echo going to high and then starting
; wait = 6
; # of clicks of wait = 2(r17) + 1
; so, 58.772clk/cm or 59 = 3(x) + 7, x = 26

#include "config.inc"

.equ	one_cm, 76

; wait subroutine takes ~2 clks per iteration
.equ	delay2, 4				; 1 clk/us * 1
.equ	delay10, 20				; 1 clk/us * 10

.section .data
cm:
	.byte		8

.section .text
    	.global     signal_init
    	.global     signal_task
    	.global		cm

signal_init:
	sbi	SIGNAL_DIR, TRIG
	cbi	SIGNAL_DIR, ECHO

	sbi	SIGNAL_DIR, T0
	cbi	SIGNAL_PORT, T0

    	ret

; data sheet for HC-SR04 call for the trigger to be on low, set to high
; for 10us, then set to low again, the echo pin will be set to high as soon as
; the trigger pin goes to low again, and stays high until
signal_task:

	cbi	SIGNAL_PORT, ECHO

	cbi	SIGNAL_PORT, TRIG	; set trigger low
	ldi	r17, delay2		; set r17 to delay2, for 2 clks(2 us)
	call	wait			; wait 2us

	call	buzz_task
	sbi	SIGNAL_PORT, TRIG	; set high
	ldi	r17, delay10		; set r17 to delay10, for 10 clks(10 us)
	call	wait			; wait 10us

	cbi	SIGNAL_PORT, TRIG	; set back to low

wait_for_echo:
	sbis	SIGNAL_PIN, ECHO	; need to wait for start of echo to start
	rjmp	wait_for_echo		; not set? keep waiting

	sbi	SIGNAL_PORT, T0

get_echo:
	clr	r18				; clear counter
start:
	inc	r18				; increment counter
	tst	r18				; is counter 0?
	breq	done			; if overflow, r18 will be 0, exit

	ldi	r17, one_cm			; load r17 with one_cm value
	call	wait         	; wait # clks for one cm

	sbic	SIGNAL_PIN, ECHO ; skip to done if echo clear
	rjmp	start			; repeat if not clear
done:
	sts	cm, r18
    	ret

; wait subroutine
wait:
	dec      r17
	brne     wait
	ret
