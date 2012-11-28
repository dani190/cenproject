class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :pushover_token, :pushover_user, :student_number
end
