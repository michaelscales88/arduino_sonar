#include "config.inc"

.section    .text
    .global     main_loop

    .extern     signal_task
	.extern		led_task
    ;.extern     buzz_task
    ;.extern    LCD_task

main_loop:
1:
    lds		r16, trigger
    cpi		r16, 1
    brne	1b

    ; give all tasks a chance to run
	call	signal_task
	call	led_task
    ;call	buzz_task
    ;call	LCD_task

    ; reset the trigger variable
    sts		trigger, r1
    rjmp	main_loop
