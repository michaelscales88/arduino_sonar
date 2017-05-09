==================
Development Tools
==================

Arduino IDE
============

The Arduino IDE is necessary for interfacing with the Arduino board. Thought the IDE itself was not used much in the creation of this project, it is useful for testing out C code on the Arduino as a proof of concept. The real reason this software was installed is because it contains two necessary components: AVRDUDE and AVR-GCC

AVR-GCC
=======

AVR-GCC is the compiler used to convert C or assembly files into machine-readable object files. These object files are then linked together into a static library, and finally output as a HEX file (also known as a sketch).  

AVRDUDE
========

AVRDUDE is the command-line tool used for reading, writing, and manipulating AVRs. For the purposes of this project, it was used to load the sketch file(s) into the AVR's flash memory.

Makefile
=========

The makefile (found here_) was used to automatedly clean, build, and load the program. Not entirely necessary, but saves a lot of typing.

.. _here: https://github.com/ACC-COSC2325-001-SP17/groupproject2-team-alpha/blob/master/Makefile


