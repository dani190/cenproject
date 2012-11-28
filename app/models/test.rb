require 'serialport'
require 'rubygems'

sp = SerialPort.new "/dev/ttyAMA0", 9600
puts "HELLO"

while 1
	if sp.gets
		puts "TEST"
		sp.write "SOME"	
	end
	#puts sp.read.to_s
	#puts sp.read.scan(/.{2}/).map{ |c| c.hex.chr }.join
end
sp.close
