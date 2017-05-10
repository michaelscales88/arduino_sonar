#tools.mk
#============================

AVRGCC  :=  $(AVRBIN)/avr-gcc
AVRGPP  :=  $(AVRBIN)/avr-g++
AVRDUDE :=  $(AVRBIN)/avrdude
OBJCOPY :=  $(AVRBIN)/avr-objcopy
OBJDUMP :=  $(AVRBIN)/avr-objdump

# include settings for these tools
#include $(MINC)/gcc-flags.mk
#include $(MINC)/as-flags.mk

debug_tools:
	@echo AVRGCC = $(AVRGCC)


