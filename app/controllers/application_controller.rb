class ApplicationController < ActionController::Base

private

  def alreadyautenticated
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated
        roledirection        
      end
    rescue 
      flash[:success] = 'Escriba un usuario y una contraseña' if !autenticated
    end
  end

  def roledirection
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated.role == "admin"
        redirect_to admin_path
      elsif autenticated.role == "vote"
        redirect_to votologin_path
      elsif autenticated.role == "view"
        redirect_to view_path
      end
    rescue 
      redirect_to login_path
    end
  end

  def adminPermit
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated.role != "admin"
        flash[:success] = 'No tiene permiso'
        redirect_to login_path
      end  
    rescue 
      redirect_to login_path
    end
  end

  def votePermit
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated.role != "vote"
        flash[:success] = 'No tiene permiso' if !autenticated
        redirect_to login_path
      end  
    rescue 
      redirect_to login_path
    end
  end

  def viewPermit
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated.role == "admin"
        flash[:success] = 'Permiso Organizador'        
      elsif autenticated.role != "view"
        flash[:success] = 'No tiene permiso' if !autenticated
        redirect_to login_path
      end  
    rescue 
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
