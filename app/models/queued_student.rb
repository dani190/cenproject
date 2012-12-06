class QueuedStudent < ActiveRecord::Base
  attr_accessible :department, :first_name, :last_name, :position, :string, :string, :student_number
  #validates :student_number, :length => { :maximum => 16, :minimum => 1 }
  
end
