require 'serialport'
require 'rubygems'

sp=SerialPort.new "/dev/ttyAMA0", 9600
puts "HELLO"
while sp.read
	
	sp.read_timeout = 100
	str1 = [sp.read].pack('H*')
        sp.write str1
end
sp.close
