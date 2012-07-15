
Wireshark Lua Dissector for the Input Director UDP protocol
===========================================================

Based on the protocol info from [uix5/info-inpdir][]. Work in progress.

Only supports version 15 of the protocol (for now), which is used by 
v1.3 beta100 of Input Director.


PS: I'm not a Lua coder, which probably explains the mess of code.


Installation
------------

First build the dissector using make, then copy it to Wireshark's plugins 
folder. Make sure Lua is enabled in Wireshark.


Usage
-----

Start Wireshark, capture some Input Director traffic. As the default port 
(31234) is also used by other protocols, make sure the `INPDIR` dissector is
used to decode the traffic (right click, 'Decode As...').

Useful filter expression: 'udp.dstport == 31234'.




[uix5/info-inpdir]: https://github.com/uix5/info-inpdir
