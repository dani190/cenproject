class Student < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :pushover_id, :phone_number, :student_number
end
