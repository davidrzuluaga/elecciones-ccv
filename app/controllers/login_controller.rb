class LoginController < ApplicationController
  before_action :alreadyautenticated, except: [:destroy]

  def index

  end

  def create
    user = User.find_by(user: params[:user])
    if user && user.authenticate(params[:password])
      cookies.permanent.signed[:session] = {value: {code: user.logincode, role: user.role}, expires: Time.now + 6.hours}
      @current_user = user
      roledirection
    else
      flash[:notice] = 'Ingrese su usuario y contraseña'
      redirect_to login_path
    end
  end

  def destroy
    cookies.delete :session
    redirect_to login_path
  end

end
