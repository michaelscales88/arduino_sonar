# objcopy elf-to-hex options

# create Intel hex output
EFLAGS	:=	-O ihex

# omit eeprom from output
EFLAGS	+=	-R .eeprom

%.hex:	%.elf
	$(OBJCOPY) $(EFLAGS) $< $@
