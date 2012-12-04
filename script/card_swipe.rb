require 'serialport'
require 'rubygems'
require "net/https"
require 'pg'
require 'active_record'

ActiveRecord::Base.establish_connection ({
  :adapter => "postgresql",
  :host => "192.168.1.101",
  :username => "pi",
  :password => "raspberry",
  :database => "cencolproject"})

class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :pushover_token, :pushover_user, :student_number
end

class QueuedStudent < ActiveRecord::Base
  attr_accessible :department, :first_name, :last_name, :position, :string, :string, :student_number
end

@cardSwipe = SerialPort.new "/dev/ttyAMA0", 9600

@cardSwipe.read_timeout = 100

puts "Welcome to Centnniel College, Please swipe your card."

while @cardSwipe
  @cardData = [@cardSwipe.read].pack('H*')
  if @cardData == ""
    hasData = false
  else
    hasData = true
  end

  if hasData == true
    puts "Student Number: " + @cardData.to_s
    puts " "
    student = Student.find_by_student_number(@cardData.to_s)

    if Student.find_by_student_number(@cardData.to_s)

      if QueuedStudent.find_by_student_number(@cardData.to_s)
        puts "You are already in Queue"
      else
        @addToQueue = QueuedStudent.new(:student_number => student.student_number, :first_name => student.first_name, :last_name => student.last_name, :department => 'Academics and Learning', :position => "1")

        if QueuedStudent.exists?
          @lastID = QueuedStudent.last.id
          clid = QueuedStudent.count(:conditions => ["id < ?", @lastID])
        else
          clid = 1
        end
        @addToQueue.save
        url = URI.parse("https://api.pushover.net/1/messages.json")
        req = Net::HTTP::Post.new(url.path)
        req.set_form_data({
        :token => "U0p4nx4rEuAz1OluXrSI4gV42D5R4O",
        :user => student.pushover_token,
        :message => "Thank you " + student.first_name + " " + student.last_name + ", you have been entered into queue for " + ". You Will recieve another notification when you are 3rd in line."
        })
        res = Net::HTTP.new(url.host, url.port)
        res.use_ssl = true
        res.verify_mode = OpenSSL::SSL::VERIFY_PEER
        res.start {|http| http.request(req) }
        puts "You have been added to the queue"
      end
    else
        puts "You are not in the student database"
    end

    puts "Welcome to Centnniel College, Please swipe your card."

  redo
  end
end
    @cardSwipe.close