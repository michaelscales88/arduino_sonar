; led task, light up them LEDs

#include "config.inc"

.equ	DIS_UNIT,	10
.equ	NUM_LEDS,	8
.equ	OFF,		0
.equ	ON, 		1

#DEFINE r28 =		NUM_LEDS
#DEFINE r29 =		DIS_UNIT

.section .data
DISTANCE:
	.byte	8
LED_COUNT:
	.byte	4
LED_INDEX:
	.byte	4
DIS_VAL:
	.byte	8

.section .text
	.global led_init
	.global led_task
	.extern	cm

led_init:
	sbi     LED_DIR, LED0
	cbi		LED_PORT, LED0
	sbi     LED_DIR, LED1
	cbi		LED_PORT, LED1
	sbi     LED_DIR, LED2
	cbi		LED_PORT, LED2
	sbi     LED_DIR, LED3
	cbi		LED_PORT, LED3
	sbi     LED_DIR, LED4
	cbi		LED_PORT, LED4
	sbi     LED_DIR, LED5
	cbi		LED_PORT, LED5
	sbi     LED_DIR, LED6
	cbi		LED_PORT, LED6
	sbi     LED_DIR, LED7
	cbi		LED_PORT, LED7

	sbi		SIGNAL_DIR, T1
	cbi		SIGNAL_PORT, T1

	ret

led_task:
	sbi		SIGNAL_PORT, T1

	lds		r17, cm
	sts		LED_COUNT, 0

led_loop:
	ldi		r18, LED_COUNT
	sts		LED_INDEX, r18

	inc		r18
	sts		LED_COUNT, r18

	cpi		r18, NUM_LEDS
	brge	done

	mul		r18, DIS_UNIT
	movw	r20, r0
	sts		DIS_VAL, r19

	lds		r18, LED_INDEX
	cpi		r17, DIS_VAL
	brge	toggle_on
	brlo	toggle_off

	rjmp	led_loop

1:
	sbi		LED_PORT, LED0
2:
	sbi		LED_PORT, LED1
3:
	sbi		LED_PORT, LED2
4:
	sbi		LED_PORT, LED3
5:
	sbi		LED_PORT, LED4
6:
	sbi		LED_PORT, LED5
7:
	sbi		LED_PORT, LED6
8:
	sbi		LED_PORT, LED7

done:
	ret
