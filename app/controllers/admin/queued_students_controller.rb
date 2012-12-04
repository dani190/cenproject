class Admin::QueuedStudentsController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :html
  
  def index
    @new_queued_student = QueuedStudent.new
  end
  
  def create
    if Student.find_by_student_number(params[:queued_student][:student_number])

      if QueuedStudent.find_by_student_number(params[:queued_student][:student_number])
        respond_to do |format|
          format.html { redirect_to '/admin/queued_students', notice: 'Student is already in Queue.' }
        end
      else
        @new_queued_student = QueuedStudent.new(params[:queued_student])
        student = Student.find_by_student_number(params[:queued_student][:student_number])
        
        if QueuedStudent.exists?
          @lastID = QueuedStudent.last.id
          clid = QueuedStudent.count(:conditions => ["id < ?", @lastID])
        else
          clid = 1
        end
        
        @new_queued_student.update_attributes :first_name => student.first_name, :last_name => student.last_name, :position => clid

        respond_to do |format|
          @new_queued_student.save
          format.html { redirect_to '/admin/queued_students', notice: 'Student was sucessfully added to queue.' }
        end
      end

    else
      respond_to do |format|
        format.html { redirect_to '/admin/queued_students', notice: 'Student was was not found.' }
      end
    end

  end
  
end