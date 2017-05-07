; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR         _DDRB
#define LED_PORT        _PORTB
#define LED1	        2
#define LED2			3
#define LED3			4

#define SIGNAL_DIR      _DDRD
#define SIGNAL_PORT		_PORTD
#define SIGNAL_PIN		_PIND

#define TRIG         7
#define ECHO            6
