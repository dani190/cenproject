require 'serialport'
require 'rubygems'
require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection ({
  :adapter => "postgresql",
  :host => "10.0.5.39",
  :username => "pi",
  :password => "raspberry",
  :database => "cencolproject"})


@cardSwipe = SerialPort.new "/dev/ttyAMA0", 9600


class Student < ActiveRecord::Base
  attr_accessible :student_number
end

#cardSwipe.write ["81"].pack('H*')

@cardSwipe.read_timeout = 100


puts "Welcome to Centnniel College, Please swipe your card."

while @cardSwipe
  @cardData = [@cardSwipe.read].pack('H*')
  @cardSwipe.write @cardData
  if @cardData == ""
    hasData = false
  else
    hasData = true
  end

  if hasData == true
    @addToCue = Student.new(:student_number => @cardData)
    @addToCue.save
    puts "Student Number: " + @cardData.to_s
    puts " "
    puts "Welcome to Centnniel College, Please swipe your card."
    @cardSwipe.write ["0x51"].pack('H*')

    redo
  end
end
    @cardSwipe.close
    #conn.close
    #puts "Connection Closed"
