# Loader options

# where is the avrdude config file
DFLAGS	:=	-C$(DUDECNF)

# turn on verbose output
DFLAGS	+=	-v

# identify the processor
DFLAGS	+=	-p$(MCU)

# identify the programmer id for this board
DFLAGS	+=	-c$(PGMR)

# what comm port are we using
DFLAGS	+=	-P$(PORT)

# do not clear the flash
DFLAGS	+=	-D

# load target
load:	$(TARGET).hex
	$(AVRDUDE) $(DFLAGS) -Uflash:w:$<:i
