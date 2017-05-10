; setup.S - initialize things before running

#include "config.inc"

	.section	.text

	.global		setup
   	.extern		clock_init
   	.extern		timer1_init
	.extern		signal_init
	.extern		led_init
	.extern		buzz_init

setup:
    	call		clock_init
    	call		timer1_init
    	call		signal_init
	call		led_init
    	call		buzz_init
	ret
