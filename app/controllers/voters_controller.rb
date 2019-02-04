class VotersController < ApplicationController
    def index
    end

    def checkVoter
        @voter = Voter.find_by(identification: params["identification"].to_i)
        @code = Code.find_by(code: params["code"])
        if @voter != nil
            if @code != nil && !@code.used
                if !@voter.voted
                    cookies.permanent.signed[:identification] = @voter.identification
                    cookies.permanent.signed[:code] = @code.code
                    redirect_to votar_path
                else
                    flash[:notice] = 'Usuario ya registra voto'
                    redirect_to root_path                
                end
            else
                flash[:notice] = 'Codigo invalido'
                redirect_to root_path
            end
        else
            flash[:notice] = 'Usuario no encontrado o no habilitado para votar'
            redirect_to root_path
        end
    end

end
