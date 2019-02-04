require 'securerandom'
class CodeController < ApplicationController
    def index
        @code = Code.new
        @codes = Code.all
    end

    def create
        number = params["/code"]["code"].to_i
        number.times do
            @code = Code.new(code: SecureRandom.hex(2), used: false)            
            @code.save
        end
        redirect_to codes_path
        flash[:success] = "#{number} codigos creados"
    end
    
    def destroy 
        Code.all.each {|a| a.update(used: true)}
        redirect_to codes_path
    end

    private

    def code_params
        params.require(:code).permit(:code)
    end
end
