# link -  build elf file from object fuiles

# optimize for space
LFLAGS  +=  -Os

# specify the processor
LFLAGS  +=  -mmcu=$(MCU)
# do not generate interrupt table
LFLAGS  +=  -mno-interrupts # do not generate interrupt table

$(TARGET).elf:	$(OBJS)
	$(AVRGCC) $(LFLAGS) $^ -o $@
