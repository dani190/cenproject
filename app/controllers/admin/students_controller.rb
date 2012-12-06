class Admin::StudentsController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :html
  
  def index
    @new_student = Student.new
    @students = Student.order("last_name ASC").all
  end
  
  def new
    @new_student = Student.new
  end
  
  def show
    @student = Student.find(params[:id])
  end
  
  def create
    @new_student = Student.new(params[:student])
    
    respond_to do |format|
      @new_student.save
      format.html { redirect_to '/admin/students', notice: 'Student was sucessfully created.'  }
    end
  end
  
  def edit
    @student = Student.find(params[:id])
    @new_student = Student.find(params[:id])
  end
  
  def update
    @new_student = Student.find(params[:id])

    respond_to do |format|
      if @new_student.update_attributes(params[:student])
        format.html { redirect_to '/admin/students', notice: 'Student was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/students', notice: 'Student was successfully deleted.' }
    end
  end
  
end