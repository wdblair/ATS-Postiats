ATS AVR
=======

This library allows you to develop firmware for 
AVR microcontrollers in ATS2. It is largely a 
continuation of the same library that's available 
in ATS.

The template system simplifies the code overall
and offers an alternative way to develop low level
applications for multiple hardware targets.

Among other differences, this version of the AVR
library doesn't require its own runtime separate 
from the normal ATS2 runtime. This is largely
due to the solely static runtime in ATS2.


Getting Started
=============== 

To start, you'll need to download and build a branch 
of the postiats compiler [1]. Note, postiats is fairly
experimental right now, so this may take some effort.

Next, install avr-gcc, avr-binutils, and avr-libc.
Eventually, we'd like to make a case for this library
to replace avr-libc but for now it uses some of its
features.

An AVR application consists of two functions, application
setup and an event handler. Setup allows you to initialize
parts of the device you plan to use, while the event handler
is called within a loop that never terminates.

    int main () {
        setup();
        
        while(1)
          event();
    }

Examples
========

The examples directory demonstrates how to accomplish
some simple tasks such as setting up timers, pulse width
modulation, ADCs, and serial communication.

Device Support
==============

Currently, this library only targets the ATmega328p since
it's used in the popular Arduino platform. With templates
we plan to expand the library to other AVR devices.

[1]: http://github.com/wdblair/ATS-Postiats
