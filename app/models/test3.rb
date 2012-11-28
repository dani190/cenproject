require 'serialport'
require 'rubygems'
require 'em-serialport'
require 'eventmachine'
sp = SerialPort.new "/dev/ttyAMA0", 9600
puts "HELLO"
str = Array.new
EM.run do
	while 1
		while sp.on_data
			
#	sp.read_timeout = 1	
		str = sp.read.scan(/.{2}/).map{ |c| c.hex.chr }
		puts str[0].length
		end
	end
end
sp.close
