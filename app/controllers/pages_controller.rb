class PagesController < ApplicationController
  
  def index
    @queued_students = QueuedStudent.order("id ASC").all
  end
  
  def display
    
  end
  
  def department_queue
    @departments = Department.order("name ASC").all
    @queued_students = QueuedStudent.order("id ASC").all
  end
  
end
