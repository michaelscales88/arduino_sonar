; led task, light up them LEDs

#include "config.inc"

.equ	near,	10
.equ	middle,	80
.equ	far,	160

#DEFINE	r18 = near
#DEFINE	r19 = middle
#DEFINE	r20 = far

#DEFINE r30 = LED

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

	ret

led_task:
	lds	r17, cm

	cpi	r17, near

	brsh	one
	cbi	LED_PORT, LED0
	rjmp	done
one:
	sbi	LED_PORT, LED0
	rjmp	done
done:
	ret
