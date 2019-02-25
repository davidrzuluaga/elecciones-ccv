class ApplicationController < ActionController::Base

def checkip
  cookie = cookies.signed[:session]
  if cookie
    code = Auth.find_by(sessioncode: cookie["code"])
    if code.log != request.ip
      # code.destroy
      # cookies.delete :session
      p code.log
      p request.ip
      @ip ||= super
      @remote_ip ||= (@env["action_dispatch.remote_ip"] || ip).to_s
      p @ip
      p @remote_ip
      p "hola"
      flash[:warning] = 'IP no coincide'
      #redirect_to root_path
    end
  else
    cookies.delete :session
    flash[:warning] = 'Escriba un usuario y una contraseña (#6)'
    redirect_to login_path
  end
end

private

  def alreadyautenticated
    cookie = cookies.signed[:session]
    if cookie
      code = Auth.find_by(sessioncode: cookie["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated
        roledirection
      end
    else
      cookies.delete :session
    end
  end

  def roledirection
    begin
      cookie = cookies.signed[:session]
      code = Auth.find_by(sessioncode: cookie["code"])
      autenticated = User.find(code.user_id)
      if autenticated.role == "admin"
        redirect_to admin_path
      elsif autenticated.role == "vote"
        redirect_to votologin_path
      elsif autenticated.role == "view"
        redirect_to view_path
      end
    rescue
      flash[:warning] = 'Ingrese su usuario y contraseña (#2)'
      cookies.delete :session
      redirect_to login_path
    end
  end

  def adminPermit
    begin
      cookie = cookies.signed[:session]
      code = Auth.find_by(sessioncode: cookie["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated.role != "admin"
        flash[:danger] = 'No tiene permiso'
        redirect_to login_path
      end  
    rescue
      flash[:warning] = 'Ingrese su usuario y contraseña (#3)'
      cookies.delete :session
      redirect_to login_path
    end
  end

  def votePermit
    begin
      cookie = cookies.signed[:session]
      code = Auth.find_by(sessioncode: cookie["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated.role != "vote"
        flash[:danger] = 'No tiene permiso' if !autenticated
        redirect_to login_path
      end  
    rescue
      flash[:warning] = 'Ingrese su usuario y contraseña (#4)'
      cookies.delete :session
      redirect_to login_path
    end
  end

  def viewPermit
    begin
      cookie = cookies.signed[:session]
      code = Auth.find_by(sessioncode: cookie["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated.role == "admin"
        flash[:success] = 'Permiso Organizador'        
      elsif autenticated.role != "view"
        flash[:danger] = 'No tiene permiso' if !autenticated
        redirect_to login_path
      end  
    rescue
      flash[:warning] = 'Ingrese su usuario y contraseña (#5)'
      cookies.delete :session
      redirect_to login_path
    end
  end

  def studentemptycode
    code = Code.find_by(code: "TEST")
    if !code
      Code.create(code: "TEST", used: true)
      code = Code.find_by(code: "TEST")
    end
    code
  end

end
