class PagesController < ApplicationController
  
  def index
    @queued_students = QueuedStudent.all
  end
  
end
