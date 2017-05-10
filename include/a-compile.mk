# a-compile.mk - targets to assemble .S files

include as-opts.mk

# find all assembly files
ASRCS   :=  $(wildcard *.S)
AOBJS   :=  $(ASRCS:.S=.o)

# implicit target to build object file
%.o:    %.S
	$(AVRGCC) $(ASMflags) $< -o $@

