; sonar.S

#include "config.h"

.section    .text
    .global sonar_init
    .global sonar_read

sonar_init:
    sbi	   SONAR_DIR, TRIGGER_PIN		; PORTD -> set the trigger pin for output
    cbi	   SONAR_DIR, ECHO_PIN		    ; PORTD -> set the ECHO_PIN pin for input
    ret

sonar_read:
    ret
