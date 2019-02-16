require 'securerandom'
class CodeController < ApplicationController
    before_action :adminPermit
    layout "admin", except: [:print]

    def index
        @code = Code.new
        @codes = Code.all
    end

    def create
        number = params["/code"]["code"].to_i
        number.times do
            # @code = 
            Code.create!(code: SecureRandom.hex(2), used: false)            
            # @code.save
        end
        redirect_to codes_path
        flash[:success] = "#{number} codigos creados"
    end
    
    def deleteunused
        Code.where(used: false).each {|a| a.destroy}
        flash[:success] = "Se han eliminado los codigos sin usar"
        redirect_to codes_path
    end

    def destroyall
        Code.all.each {|a| a.destroy}
        flash[:success] = "Se han eliminado todos los codigos"
        redirect_to codes_path
    end

    def destroy
        codigo = Code.find(params[:id])
        flash[:success] = "Se ha eliminado el codigo #{codigo.code} #{"recuerde cambiar el estatus al estudiante #{Voter.find_by(code_id: codigo.id).identification} de grado #{Group.find(Voter.find_by(code_id: codigo.id).group_id).name}"  if codigo.used }"
        codigo.destroy
        redirect_to codes_path
    end

    def print
        @codestoprint = Code.where(used: false)
    end

    private

    def code_params
        params.require(:code).permit(:code)
    end
end
