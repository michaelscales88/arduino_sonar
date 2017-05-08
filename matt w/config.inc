; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR         _DDRB
#define LED_PORT        _PORTB

#define LED0	        2
#define LED1		3
#define LED2		4

#define SIGNAL_DIR      _DDRD
#define SIGNAL_PORT	_PORTD

#define	SIGNAL_PIN	_PIND

#define TRIG         	5
#define ECHO            6

#define T0		2
#define T1		3
#define T2		4
