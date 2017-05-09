; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR         _DDRC
#define LED_PORT        _PORTC

#define LED0	        0
#define LED1		2
#define LED2		4

#define SIGNAL_DIR      _DDRC
#define SIGNAL_PORT	_PORTC

#define	SIGNAL_PIN	_PINC

#define TRIG         	1
#define ECHO            3

#define T0		5
#define T1		7
