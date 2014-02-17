LuCI Lamp
=========

Simple LuCI module for GPIO-connected relay switching.

Module orginally created for TP-Link TL-WR741N which has [well known GPIO pinout](http://wiki.openwrt.org/toh/tp-link/tl-wr741nd#gpio.mapping) and uses even more known ar9331 atheros chip.


Example hardware configuration
==================
For demonstration I have used the tplink wr741n router and one of these cheap "5v relay modules" from ebay, which already come with a transistor, diode and led - all which is needed to connect relay to uC such as arduino. My mistake was that AFAIK wr741n provides only 9V output from dc supply and 3.3V from on-board voltage regulator. 3.3V should be fine depending on the relay, but this is the line that is directly connected to ar9331, and probably has much lower current output & spike tolerance, so 9V was choice for me. Relays' coils AFAIK are driven by current, so by measuring resistance on coil and using Ohm law (U=RI), we can calculate resistor which should be added for it to work safely with 9V.

For GPIO I used GPIO7 which on my revision of wr741n was accessible by Test point 10. Much easier to solder to than an ar9331 pad. For 'easy' soldering removing leds_gpio kernel module, and using one of these LED connected GPIOs would be my second choice.
