; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR         _DDRB
#define LED_PORT        _PORTB
#define LED_PIN         7

#define SONAR_DIR       _DDRD
#define SONAR_PORT      _PORTD
#define TRIGGER_PIN     1               ; initial signal
#define ECHO_PIN        2               ; return signal

#define DELAY           100             ; delay constant