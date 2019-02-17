class VotersController < ApplicationController
    before_action :votePermit

    def index
    end

    def checkVoter
        @voter = Voter.find_by(identification: params["identification"].to_i)
        @code = Code.find_by(code: params["code"])
        if @voter != nil
            if @code != nil && !@code.used
                if !@voter.voted
                    cookies.permanent.signed[:identification] = {value: @voter.identification, expires: Time.now + 5.minutes}
                    cookies.permanent.signed[:code] = {value: @code.code, expires: Time.now + 5.minutes} 
                    redirect_to votar_path
                else
                    flash[:warning] = 'Usuario ya registra voto'
                    redirect_to root_path                
                end
            else
                flash[:danger] = 'Codigo invalido'
                redirect_to root_path
            end
        else
            flash[:danger] = 'Usuario no encontrado o no habilitado para votar'
            redirect_to root_path
        end
    end

end
