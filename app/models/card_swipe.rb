  require 'serialport'
  require 'rubygems'
  require 'pg'

  cardSwipe = SerialPort.new "/dev/ttyAMA0", 9600
  
  puts "HELLO"
  
  cardSwipe.write "FLEAAAAAAZ"  

  while cardSwipe.read
    cardSwipe.read_timeout = 100
    cardData = [cardSwipe.read].pack('H*')
    cardSwipe.write cardData
  end
  cardSwipe.close
