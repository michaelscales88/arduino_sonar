==========
Readme
==========

Group Project 2 Members
=======================

John Bradshaw, Michael Scales, Matthew Wiederaenders, Nicholas Moore

To run the project
===================

Under the project directory, do:

make clean -> make -> make load

This should load the program onto your arduino

To view the report
===================

Clone the repository onto your system, and navigate to docs/build/html/index.html. This is the title page and table of contents for the report, and will allow you to view each section by clicking on the appropriate link.

Discussion
==========

Our assembly program is designed to use the HC-SR04 ultrasound unit in order to measure the distance of an object from our unit.
The program then uses that distance to provide an audio and visual reference of the distance. With more time we could have added an LCD display which would display the distance numerically.

| This program starts in main where we configure our:
|    - LED lights
|    - Buzzer
|    - Trigger and echo pins for our ultrasound unit

| As we are looping the logic goes:
|    1. Send out an ultrasound signal
|    2. Receive the echo of the signal and measure it's length in uS (microseconds)
|    3. Convert the uS into a distance
|    4. Using the distance we can activate some number of our LED lights
|    5. Using the cm value we control the delay of our buzzer
|    6. We loop again and repeat
