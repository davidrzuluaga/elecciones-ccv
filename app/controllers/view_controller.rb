class ViewController < ApplicationController
  before_action :viewPermit

  def index
    autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
    @autenticated = autenticated.role if autenticated  
  end
end
