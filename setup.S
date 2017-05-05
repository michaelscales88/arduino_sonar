; setup.S - nitialize things before running

#include "config.h"

    .section    .text
    .global     setup
    .extern     clock_init
    .extern     timer_init
    .extern     led_init
    .extern     sonar_init
;    .extern     buzz_init

setup:
    call        clock_init              ; set the clock speed
    call        timer_init              ; set up the timer
    call        sonar_init              ; init echo/trigger pins
    call        led_init                ; init led pin
;    call        buzz_init               ; init buzzer pin
    ret
