; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR         _DDRB
#define LED_PORT        _PORTB
#define LED_PIN         7

#define TRIGGER_DIR     _DDRD
#define TRIGGER_PORT    _PORTD
#define TRIGGER_PIN     1

#define ECHO_DIR        _DDRD
#define ECHO_PORT       _PORTD
#define ECHO_PIN        2               ; echo pin

#define PIND            0x09            ; the input PIND register
#define DELAY           100             ; delay constant
