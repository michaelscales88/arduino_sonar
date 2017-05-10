#include "config.inc"

.section    .text
    .global    main_loop
    .extern    signal_task
    .extern    led_task
    .extern    buzz_task

main_loop:
1:
    lds	        r16, trigger          ; get value of trigger
    cpi		r16, 1                ; wait for a trigger to be true
    brne	1b

    ; give all tasks a chance to run
    call	signal_task           ; measure the time from trigger to echo
    call	led_task              ; illuminate lights corresponding to distance
    call	buzz_task             ; create audible indicator of distance

    ; reset the trigger variable
    sts     	trigger, r1
    rjmp	main_loop
