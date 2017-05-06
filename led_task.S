; led_task.S

#include "config.h"

.section    .text
    .global led_init

led_init:
    sbi     LED_DIR, LED_PIN        ; set input
    cbi     LED_PORT, LED_PIN       ; set output
    ret
