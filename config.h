; config.inc

#include <avr/io.h>
#include "../include/AVRSpecialRegs.inc"

#define LED_DIR     _DDRB
#define LED_PORT    _PORTB
#define LED_PIN     7

#define TRIGGER_DIR    _DDRD
#define TRIGGER_PORT   _PORTD
#define TRIGGER_PIN    1

#define PIND     0x09

#define ECHO        2
#define DELAY       100

; #define PIND        0x09			; the input PIND register
;#define LED_PIN     5			    ; Define LED pin on PORTB
; #define	TRIGGER     1			; Trigger Pin
; #define ECHO        2			; Echo Pin
; #define DELAY       100			; Delay constant
