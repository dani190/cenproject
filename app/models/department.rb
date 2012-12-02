class Department < ActiveRecord::Base
  attr_accessible :desk, :name
  
  has_many :queued_students
end
