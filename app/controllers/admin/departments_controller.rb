class Admin::DepartmentsController < ApplicationController
  
  def index
    @departments = Department.order("name ASC").all
  end
  
  def new
    @new_department = Department.new
  end
  
  def create
    @new_department = Department.new(params[:department])
    respond_to do |format|
      @new_department.save
      format.html { redirect_to '/admin/departments', notice: 'Department was sucessfully created.' }
    end
  end
  
  def edit
    @department = Department.find(params[:id])
    @new_department = Department.find(params[:id])
  end
  
  def update
    @new_department = Department.find(params[:id])

    respond_to do |format|
      if @new_department.update_attributes(params[:department])
        format.html { redirect_to '/admin/departments', notice: 'Department was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @department = Department.find(params[:id])
    @department.destroy

    respond_to do |format|
      format.html { redirect_to '/admin/departments', notice: 'Department was successfully deleted.' }
    end
  end
  
end