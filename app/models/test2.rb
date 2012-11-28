require "rubypython"
RubyPython.start
print "START"
serial = RubyPython.import("serial")
ser=serial.Serial("/dev/ttyAMA0", 9600)

        x=ser.readlines()
        print x


ser.close()

RubyPython.stop




