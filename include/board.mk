# Board specific definitions for AVR project

# defaults
MCU		:= atmega328p
PGMR	:= arduino
FREQ	:= 16000000L

ifeq ($(BOARD), UNO)
	MCU		:= atmega328p
	PGMR	:= arduino
endif

ifeq ($(BOARD), MEGA)
	MCU		:= atmega2560
	PGMR	:= wiring
endif

ifeq	($(BOARD), TEENSY)
	MCU		:= atmega32u4
	PGMR	:= arduino
endif

debug_board:
	@echo MCU = $(MCU)
	@echo PGMR = $(PGMR)
	@echo PORT = $(PORT)
	@echo FREQ = $(FREQ)
