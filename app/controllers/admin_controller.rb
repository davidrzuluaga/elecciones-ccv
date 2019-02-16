class AdminController < ApplicationController
  before_action :adminPermit
  layout "admin"

  def index
     
  end
  
end
