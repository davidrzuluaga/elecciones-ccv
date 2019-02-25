class ApplicationController < ActionController::Base

def checkip
  code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
  if code
    if code.log != request.ip
      # code.destroy
      # cookies.delete :session
      p code.log
      p request.ip
      @ip ||= super
      @remote_ip ||= (@env["action_dispatch.remote_ip"] || ip).to_s
      p @ip
      p @remote_ip
      flash[:warning] = 'IP no coincide'
      #redirect_to root_path
    end
  else
    cookies.delete :session
    flash[:warning] = 'Escriba un usuario y una contraseña...'
    redirect_to login_path
  end
end

private

  def alreadyautenticated
    begin
      code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated
        roledirection
      end
    rescue 
      cookies.delete :session
      flash[:warning] = 'Escriba un usuario y una contraseña' if !autenticated
    end
  end

  def roledirection
    begin
      code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
      autenticated = User.find(code.user_id)
      if autenticated.role == "admin"
        redirect_to admin_path
      elsif autenticated.role == "vote"
        redirect_to votologin_path
      elsif autenticated.role == "view"
        redirect_to view_path
      end
    rescue 
      cookies.delete :session
      redirect_to login_path
    end
  end

  def adminPermit
    begin
      code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated.role != "admin"
        flash[:danger] = 'No tiene permiso'
        redirect_to login_path
      end  
    rescue 
      cookies.delete :session      
      redirect_to login_path
    end
  end

  def votePermit
    begin
      code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated.role != "vote"
        flash[:danger] = 'No tiene permiso' if !autenticated
        redirect_to login_path
      end  
    rescue 
      cookies.delete :session
      redirect_to login_path
    end
  end

  def viewPermit
    begin
      code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
      autenticated = User.find(code.user_id)
      checkip
      if autenticated.role == "admin"
        flash[:success] = 'Permiso Organizador'        
      elsif autenticated.role != "view"
        flash[:danger] = 'No tiene permiso' if !autenticated
        redirect_to login_path
      end  
    rescue 
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
