class ApplicationController < ActionController::Base

private

  def alreadyautenticated
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated
        roledirection        
      end
    rescue 
      flash[:notice] = 'Escriba un usuario y una contraseña' 
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
        flash[:notice] = 'No tiene permiso'
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
        flash[:notice] = 'No tiene permiso'
        redirect_to login_path
      end  
    rescue 
      redirect_to login_path
    end
  end

  def viewPermit
    begin
      autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
      if autenticated.role != "view"
        flash[:notice] = 'No tiene permiso'
        redirect_to login_path
      end  
    rescue 
      redirect_to login_path
    end
  end

end
