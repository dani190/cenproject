class Admin::MainController < ApplicationController
  before_filter :authenticate_admin!
  respond_to :html
  
  def index
    
  end
  
end