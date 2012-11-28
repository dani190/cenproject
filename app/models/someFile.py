#!/usr/bin/env python
import serial
serialport = serial.Serial("/dev/ttyAMA0", 9600, timeout=0.5)
while 1:
	response=serialport.readlines()
	print response
