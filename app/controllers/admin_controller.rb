class AdminController < ApplicationController
  before_action :adminPermit
  layout "admin"

  def index
  end
  
  def voterslogout
    User.where(role: "vote").update(logincode: SecureRandom.hex(10))
    Auth.where(user: User.where(role: "vote")).each {|u| u.destroy}    
    flash[:success] = 'Sesiones de votación cerradas'
    redirect_to root_path
  end

  def claves
    @user = "organizador" if params[:id].to_i == 1
    @user = "observador" if params[:id].to_i == 2
    @user = "votante" if params[:id].to_i == 3
  end
  
  def cambiarclave 
    if params[:password] != ""
      user = "organizador" if params[:id].to_i == 1
      user = "observador" if params[:id].to_i == 2
      user = "votante" if params[:id].to_i == 3
      users = User.where(user: user)
      users.update(password: params[:password], logincode: SecureRandom.hex(10))
      Auth.where(user: users).each {|u| u.destroy}
      flash[:success] = "Contraseña para #{user} cambiada"
      redirect_to root_path
    else
      flash[:danger] = "Contraseña invalida"
      redirect_to claves_path(params[:id])
    end
  end

  def sessions
    @sesiones = Auth.all
    Auth.where("created_at <= ?", Time.now - 6.hours).each {|u| u.destroy}    
  end

  def delete_session
    session = Auth.find(params[:id])
    session.destroy
    flash[:success] = "Sesión cerrada con exito"
    redirect_to sessions_path
  end
end
