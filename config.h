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

#define PULSE_DELAY           100             ; 10ms pulse delay cycling trigger on and off
#define MAX_DELAY             200             ; this needs to account for a 60ms delay between triggers
