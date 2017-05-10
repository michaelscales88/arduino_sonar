# compile.mk - build defintions

# assembly language settings ==============================
ASRCS = $(wildcard *.S)
AOBJS	= $(ASRCS:.S=.o)

# Set the processor
FLAGS	:=	-mmcu=$(MCU)

# set processor speed
FLAGS	+=	-DF_CPU=$(FREQ)

# assemble only, do not link
AFLAGS	:=	-c $(FLAGS)


# set assembler type
AFLAGS	+=	-x assembler-with-cpp

# add paths for header files
AFLAGS	+=	$(INCLUDES)

# assembler target
%.o:	%.S
	$(AVRGCC) $(AFLAGS) $< -o $@

# c language settings =====================================
CSRCS = $(wildcard *.c)
COBJS	= $(CSRCS:.c=.o)

# set compiler flags
CFLAGS	:=	-c $(FLAGS)

# add paths for header files
CFLAGS	+=	$(INCLUDES)

# c target
%.o:	%.c
	$(AVRGCC) $(CFLAGS) $< -o $@

# c language settings =====================================
CPPSRCS = $(wildcard *.cpp)
CPPOBJS	= $(CPPSRCS:.cpp=.o)

# set compiler flags
CPPFLAGS	:=	-c $(FLAGS)

# add paths for header files
CPPFLAGS	+=	$(INCLUDES)

# cpp target
%.o:	%.cpp
	$(AVRGPP) $(CPPFLAGS) $< -o $@

# build list of all object files
OBJS	:= $(AOBJS) $(COBJS) $(CPPOBJS)

debug-compile:
	@echo $(OBJS)
