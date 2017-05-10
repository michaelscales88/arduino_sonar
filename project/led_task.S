; led task, light up them LEDs

#include "config.inc"

.equ	MAX_LED_RANGE,	81
.equ	NUM_LED,	8
.equ	DIS_UNIT,	10

.equ	dis0, 10
.equ	dis1, 20
.equ	dis2, 30
.equ	dis3, 40
.equ	dis4, 50
.equ	dis5, 60
.equ	dis6, 70
.equ	dis7, 80

#DEFINE r17 = dis0
#DEFINE r18 = dis1
#DEFINE r19 = dis2
#DEFINE r20 = dis3
#DEFINE r21 = dis4
#DEFINE r22 = dis5
#DEFINE r23 = dis6
#DEFINE r24 = dis7

#DEFINE r25 = MAX_LED_RANGE
#DEFINE r26 = NUM_LED
#DEFINE r27 = DIS_UNIT

.section .data
LED_INDEX:
	.byte	4

.section .text
	.global led_init
	.global led_task
	.extern	cm

led_init:
	sbi     LED_DIR, LED0
	cbi	LED_PORT, LED0
	sbi     LED_DIR, LED1
	cbi	LED_PORT, LED1
	sbi     LED_DIR, LED2
	cbi	LED_PORT, LED2
	sbi     LED_DIR, LED3
	cbi	LED_PORT, LED3
	sbi     LED_DIR, LED4
	cbi	LED_PORT, LED4
	sbi     LED_DIR, LED5
	cbi	LED_PORT, LED5
	sbi     LED_DIR, LED6
	cbi	LED_PORT, LED6
	sbi     LED_DIR, LED7
	cbi	LED_PORT, LED7

	sbi	SIGNAL_DIR, T1
	cbi	SIGNAL_PORT, T1

	ret

led_task:
	sbi	SIGNAL_PORT, T1

off:
	cbi	LED_PORT, LED0
	cbi	LED_PORT, LED1
	cbi	LED_PORT, LED2
	cbi	LED_PORT, LED3
	cbi	LED_PORT, LED4
	cbi	LED_PORT, LED5
	cbi	LED_PORT, LED6
	cbi	LED_PORT, LED7

	lds	r16, cm
	cpi	r16, MAX_LED_RANGE
	brge	done
	cpi	r16, 0
	brlt	done

	clr	r28
led_loop:
	inc	r28
	subi	r16, DIS_UNIT
	tst	r16
	brlt	set_led
	rjmp	led_loop

set_led:
	cpi	r28, 8
	breq	8f
	cpi	r28, 7
	breq	7f
	cpi	r28, 6
	breq	6f
	cpi	r28, 5
	breq	5f
	cpi	r28, 4
	breq	4f
	cpi	r28, 3
	breq	3f
	cpi	r28, 2
	breq	2f
	cpi	r28, 1
	breq	1f

	rjmp	done

1:	sbi	LED_PORT, LED0
2:	sbi	LED_PORT, LED1
3:	sbi	LED_PORT, LED2
4:	sbi	LED_PORT, LED3
5:	sbi	LED_PORT, LED4
6:	sbi	LED_PORT, LED5
7:	sbi	LED_PORT, LED6
8:	sbi	LED_PORT, LED7

done:
	ret
