require 'serialport'
require 'rubygems'

sp=SerialPort.new "/dev/ttyAMA0", 9600
puts "HELLO"
while true
	sp.read_timeout = 50
	str5 = [sp.read].pack('H*')
        sp.write str5
end
sp.close
