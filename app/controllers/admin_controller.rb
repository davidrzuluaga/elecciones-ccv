class AdminController < ApplicationController
  before_action :adminPermit
  layout "admin"

  def index
     
  end
  
  def voterslogout
    User.where(role: "vote").update(logincode: SecureRandom.hex(10))
    flash[:success] = 'Sesiones de votación cerradas'
    redirect_to root_path
  end

  def claves
    @user = "organizador" if params[:id].to_i == 1
    @user = "observador" if params[:id].to_i == 2
    @user = "votante" if params[:id].to_i == 3
  end
  
  def cambiarclave 
    user = "organizador" if params[:id].to_i == 1
    user = "observador" if params[:id].to_i == 2
    user = "votante" if params[:id].to_i == 3
    User.where(user: user).update(password: params[:password], logincode: SecureRandom.hex(10))
    flash[:success] = "Contraseña para #{user} cambiada"
    redirect_to root_path
  end
end
