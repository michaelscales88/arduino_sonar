; led task, light up them LEDs

#include "config.inc"

.equ	near,	5
.equ	middle, 10
.equ	far,	20

.section .text
	.global led_init
	.global led_task
	.extern	cm

led_init:
	sbi     LED_DIR, LED1
	cbi		LED_PORT, LED1
	;sbi		LED_PORT, LED1

	sbi     LED_DIR, LED2
	cbi		LED_PORT, LED2

	sbi     LED_DIR, LED3
	cbi		LED_PORT, LED3

	ret

led_task:
	sbi		LED_PORT, LED1
	lds		r17, 20

	sbi		LED_PORT, LED1
	cp		r17, near
	brlo	done

	sbi		LED_PORT, LED2
	cp		r17, middle
	brlo	done

	sbi		LED_PORT, LED3
	cp		r17, far
	brlo	done

done:
	ret
