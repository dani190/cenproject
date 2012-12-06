class PagesController < ApplicationController
  
  def index
    
  end
  
  def queue
    @queued_student = QueuedStudent.find_by_student_number(params[:queue][:student_number])
  end
end
