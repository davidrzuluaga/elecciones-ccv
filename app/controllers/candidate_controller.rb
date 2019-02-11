class CandidateController < ApplicationController
    before_action :votePermit
    def index 
        @votante = Voter.find_by(identification: cookies.signed[:identification])
        @codeused = Code.find_by(code: cookies.signed[:code])
        begin
            if @votante != nil || @codeused != nil
                @localpositions = Position.where(group_id: @votante.group_id)
                @globalpositions = Position.where(group: Group.find_by(name: "global"))
                @votestatus = Vote.where(code_id: @codeused)
                Code.find(@codeused.id).update(used: true)
                Voter.find(@votante.id).update(voted: true)
            else
                flash[:notice] = 'Ingrese su identificacion y su codigo'
                redirect_to root_path
            end
        rescue
            flash[:notice] = 'Error'
            cookies.delete(:identification)
            cookies.delete(:code)
            redirect_to root_path
        end
    end
    
    def registevote
        @codeused = Code.find_by(code: cookies.signed[:code])
        Vote.create!(candidate_id: params["candidate"].to_i, code: @codeused, position_id: Candidate.find(params["candidate"].to_i).position_id)
        flash[:notice] = 'Voto Registrado, vote por el siguiente'
        redirect_to votar_path
    end


end