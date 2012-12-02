class Admin::QueuedStudentsController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :html
  
  def index
    @new_queued_student = QueuedStudent.new
  end
  
  def create
    @new_queued_student = QueuedStudent.new(params[:queued_student])
    respond_to do |format|
      @new_queued_student.save
      format.html { redirect_to '/admin/queue_student', notice: 'Student was sucessfully added to queue.'  }
    end
  end
  
end