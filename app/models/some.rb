require 'serialport'

SerialPort.open "/dev/ttyAMA0", 9600 do |sp|
	sp.read_timeout = 0
	puts [sp.read]
end
