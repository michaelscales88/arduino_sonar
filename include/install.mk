# install.mk - this file contains system specific definitions
#=============================================================

# set the absolute path to the Arduino IDE
AVRBASE := /Applications/Arduino.app/Contents/Java/hardware

# locate this file on your system
DUDECNF	:=	$(AVRBASE)/tools/avr/etc/avrdude.conf

# these lines should not change unless the IDE is modified
AVRBIN  :=  $(AVRBASE)/tools/avr/bin
AVRINC  :=  -I$(AVRBASE)/tools/avr/avr/include/avr
AVRINC  +=  -I$(AVRBASE)/arduino/avr/cores/arduino

# what tool do we use to clean up
RM	:= rm -f
ifeq ($(OS), Windows_NT)
	RM	= del
endif

debug_install:
	@echo install definitions
	@echo AVRBASE = $(AVRBASE)
	@echo DUDECNF = $(DUDECNF)
	@echo AVRBIN = $(AVRBIN)
	@echo AVRINC = $(AVRINC)
