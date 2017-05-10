#Master Makefile for AVR projects

# Makefile Component layout
#
# AVRmaster
# 	+- install - system dependent settings
# 	+- board - set board defs bases on project settings
# 	+- tools - set paths to all buiulkd tools
# 	+- compile2obj - flags used to generate object files
# 	+- obj2elf - link obj files into elf
# 	+- elf2hex - create hex file from elf
# 	+- loader - load hex file to board
# 	+- utility - various utility targets

# targets follow ----------------------------------------------------
all:	$(TARGET).hex

# project directories are below this point
MINC	:=	../include

# basic make setup
include	$(MINC)/board.mk			# identify this board
include $(MINC)/install.mk			# where are the AVR tools locates
include $(MINC)/tools.mk			# define the tool definitions

# build definition files
include	$(MINC)/compile2obj.mk			# build rules
include	$(MINC)/obj2elf.mk				# link to elf rules
include $(MINC)/elf2hex.mk		# elf to hex rules
include	$(MINC)/loader.mk			# load to board rules

# add utility targets
include $(MINC)/utility.mk			#
