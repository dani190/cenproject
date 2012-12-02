class PagesController < ApplicationController
  
  def index
    @queued_students = QueuedStudent.all
  end
  
  def display
    
  end
  
  def department_queue
    
  end
  
end
