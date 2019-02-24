class LoginController < ApplicationController
  before_action :alreadyautenticated, except: [:destroy]

  def index
  end

  def create
    user = User.find_by(user: params[:user])
    if user && user.authenticate(params[:password])
      sessioncode = SecureRandom.hex(10)
      Auth.create(user: user, sessioncode: sessioncode, log: request.ip)
      cookies.permanent.signed[:session] = {value: {code: sessioncode, usercode: user.logincode}, expires: Time.now + 6.hours}
      @current_user = user
      roledirection
    else
      flash[:success] = 'Ingrese su usuario y contraseña'
      redirect_to login_path
    end
  end

  def destroy
    Auth.find_by(sessioncode: cookies.signed[:session]["code"]).destroy
    cookies.delete :session
    redirect_to login_path
  end

end
