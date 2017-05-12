; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR         _DDRD
#define LED_PORT        _PORTD
#define LED0		0
#define LED1		1
#define LED2		2
#define LED3		3
#define LED4		4
#define LED5		5
#define LED6		6
#define LED7		7

#define SIGNAL_DIR      _DDRB
#define SIGNAL_PORT	_PORTB
#define	SIGNAL_PIN	_PINB
#define TRIG		0
#define ECHO		1
#define T0		2
#define T1		3

#define BUZZ_DIR	_DDRB
#define BUZZ_PORT	_PORTB
#define BUZZ_PIN	12

