# make asm

$(TARGET).elf:	$(OBJS)
	$(OBJDUMP) -d $^

#make asmBuzzer.elf
#avr-objdump -d asmBuzzer.elf
