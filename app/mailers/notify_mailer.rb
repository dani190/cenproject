class NotifyMailer < ActionMailer::Base
  
  self.default_url_options = { :host => "www.jjdowns.com" }
  self.delivery_method = :smtp
  self.smtp_settings = {
    address: "value"'smtp.rogerswirelessdata.com',
    port: 25
    }
    
  default from: "\"Centennial College\" <notifications@cencol.com>"
  
  def you_are_in_queue(queued_student)
    student = Student.find_by_student_number(queued_student)
    mail(to: 'registration@jjdowns.com', subject: 'New customer has registered (' + student.first_name + " " + student.last_name + ')', template_path: 'account_mailer', template_name: 'new_customer_signed_up')
  end
  
  def you_are_third(queued_student)
    mail(to: 'registration@jjdowns.com', subject: 'New customer has registered (' + student.first_name + " " + student.last_name + ')', template_path: 'account_mailer', template_name: 'new_customer_signed_up')
  end
  
end
