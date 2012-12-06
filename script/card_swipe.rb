# Gems for ruby script
require 'serialport'
require 'rubygems'
require "net/https"
require 'pg'
require 'active_record'
require 'twilio-ruby'

# connect to postgresql database on other raspberry pi (192.168.1.101)
ActiveRecord::Base.establish_connection ({
  :adapter => "postgresql",
  :host => "192.168.1.101",
  :username => "pi",
  :password => "raspberry",
  :database => "cencolproject"})

# Models
class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :pushover_id, :phone_number, :student_number
end

class QueuedStudent < ActiveRecord::Base
  attr_accessible :department, :first_name, :last_name, :position, :string, :string, :student_number
end

# Connect to serial port
@cardSwipe = SerialPort.new "/dev/ttyAMA0", 9600
@cardSwipe.read_timeout = 100

# Start console log
puts "Welcome to Centnniel College, Please swipe your card."

# Start card swipe script
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
        
        if QueuedStudent.exists?
          @lastID = QueuedStudent.last.id
          nowid = QueuedStudent.count(:conditions => ["id <= ?", @lastID]) + 1
        else
          nowid = 1
        end

        @addToQueue = QueuedStudent.new(:student_number => student.student_number, :first_name => student.first_name, :last_name => student.last_name, :department => 'Academics and Learning', :position => nowid)
        @addToQueue.save

        # If the student has pushover use it else use sms
        if student.pushover_id == ""
                    
          #Twilio API (SMS Service)
          account_sid = 'AC878d8986d14b1c01cf3e1f1788ab7f18'
          auth_token = 'ccd3831f37cd3cfde7221ab36b384a47'
          @sms_student = Twilio::REST::Client.new account_sid, auth_token

          @sms_student.account.sms.messages.create(
            :from => '+16479315434',
            :to => student.phone_number,
            :body => "Thank you " + student.first_name + " " + student.last_name + ", you have been entered into queue for Academics and Learning. You will recieve another notification when you are 3rd in line."
          )
          
        else
          
          #Pushover API (iOS Push Notification Service)
          url = URI.parse("https://api.pushover.net/1/messages.json")
          req = Net::HTTP::Post.new(url.path)
          req.set_form_data({
          :token => "U0p4nx4rEuAz1OluXrSI4gV42D5R4O",
          :user => student.pushover_id,
          :message => "Thank you " + student.first_name + " " + student.last_name + ", you have been entered into queue for " + ". You Will recieve another notification when you are 3rd in line."
          })
          res = Net::HTTP.new(url.host, url.port)
          res.use_ssl = true
          res.verify_mode = OpenSSL::SSL::VERIFY_PEER
          res.start {|http| http.request(req) }

        end
        
        puts "You have been added to the queue"
      end
    else
        puts "You are not in the student database"
    end
    puts " "
    puts "Welcome to Centnniel College, Please swipe your card."
    
  # Restart card swipe script once a card has been swipped and processed
  redo
  
  end
end
  # Close connection to serial port
  @cardSwipe.close