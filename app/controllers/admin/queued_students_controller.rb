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
          clid = QueuedStudent.count(:conditions => ["id <= ?", @lastID]) + 1
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
  
  def update
    @new_queued_student = QueuedStudent.find(params[:id])

    respond_to do |format|
      if @new_queued_student.update_attributes(params[:queued_student])
        format.html { redirect_to '/department_queue', notice: 'Queued Student was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end
  
  def destroy
    @queued_student = QueuedStudent.find(params[:id])
    @queued_student.destroy
    QueuedStudent.update_all("position = position - 1")
    
    if QueuedStudent.count >= 3
      @notify_this_student = QueuedStudent.where(:position => 3)
      
      @notify_this_student.each do |a|
        @department_wanted = a.department
        @a = a.student_number
      end
      @student = Student.find_by_student_number(@a)
      student = Student.find_by_student_number(@a)
      
      require "net/https"
      
      url = URI.parse("https://api.pushover.net/1/messages.json")
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data({
        :token => "U0p4nx4rEuAz1OluXrSI4gV42D5R4O",
        :user => student.pushover_token,
        :message => student.first_name + " " + student.last_name + ", you are now 3rd in the queue for " + @department_wanted + ". Please make your way to the department now.",
      })
      res = Net::HTTP.new(url.host, url.port)
      res.use_ssl = true
      res.verify_mode = OpenSSL::SSL::VERIFY_PEER
      res.start {|http| http.request(req) }
    end
    
    respond_to do |format|
      format.html { redirect_to '/department_queue', notice: 'Queued Student was successfully checked in.'}
    end
  end
  
end