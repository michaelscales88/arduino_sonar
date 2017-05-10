===========
Experiment
===========

The Idea
=========

The inspiration for this experiment came from car backup sensors. These use several small devices placed around the exterior of the car that emit ultrasonic pulses to determine the distance of potential obstacles. Our idea was to try and re-create something similar using an arduino and a few peripheral accessories. 

Board Setup
============

The board is generally setup according to the diagram below:

.. image:: circuit_diagram.jpg

It consists of an arduino connected to a breadboard, which holds 8 LEDs (red, yellow, green), an ultrasonic senosr, and a piezo buzzer.

Function
=========

After initializing the components on the board, the ultrasonic sensor sends out a pulse and waits for the echo to bounce back. Based on how long this takes, it calculates the distance in centimeters based on clock cycles using the following formula:

Time for pulse to travel 1cm and return: 58.772 us

4 MHz = 4 clk/us or about 236 clk/cm

wait = 6, # of clks of wait = 2(r17) + 1

Therefore 236 = 3(x) + 7, x = 76 clks/cm

This value is then stored in the global variable cm. Based on this value, the LEDs activate according to the following table

+---------------+---------------+
|LEDs Activated | Distance (cm) |
+===============+===============+
|8              | < 10          |
+---------------+---------------+
|7              | 10 - 20       |
+---------------+---------------+
|6              | 20 - 30       | 
+---------------+---------------+
|5              | 30 - 40       |
+---------------+---------------+
|4              | 40 - 50       |
+---------------+---------------+
|3              | 50 - 60       |
+---------------+---------------+
|2              | 60 - 70       |
+---------------+---------------+
|1              | 70 - 80       |
+---------------+---------------+
|0              | > 80          |
+---------------+---------------+

The buzzer is activated in a similar fashion, with the delay between successive clicks of the buzzer being determined by the value held in cm. The result is a device that indicates both audibly and visually how far away an object is.


