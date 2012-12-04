class QueuedStudent < ActiveRecord::Base
  attr_accessible :department, :first_name, :last_name, :position, :string, :string, :student_number
  #validates :student_number, :length => { :maximum => 16, :minimum => 1 }
  
  after_create :pushover
  
  def pushover
    
    student = Student.find_by_student_number(self.student_number)
    require "net/https"

    url = URI.parse("https://api.pushover.net/1/messages.json")
    req = Net::HTTP::Post.new(url.path)
    req.set_form_data({
      :token => "U0p4nx4rEuAz1OluXrSI4gV42D5R4O",
      :user => student.pushover_token,
      :message => "Thank you " + student.first_name + " " + student.last_name + ", you have been entered into queue for " + self.department + ". You Will recieve another notification when you are 3rd in line.",
    })
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res.start {|http| http.request(req) }
  end
  
end
