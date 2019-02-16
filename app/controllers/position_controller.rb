class PositionController < ApplicationController
  before_action :adminPermit
  layout "admin"

    def index
        @positions = Position.all.order('name ASC')
    end

    def new
        @position = Position.new
    end

    def create
        @position = Position.new(position_params)
        if @position.save
            redirect_to positionlist_path, notice: "La posición fue creado con exito"
        else
            render :new 
        end
    end

    def modify
        @position = Position.find(params[:id])
    end

    def update
        @position = Position.update(params[:id], position_params)
        redirect_to positionlist_path
    end
    def delete
        @position = Position.find(params[:id])
        @position.destroy
        flash[:success] = "Eliminado"
        redirect_to positionlist_path
    end

    def newcandidate
        @candidate = Candidate.new
    end

    def createcandidate
        @candidate = Candidate.new(candidate_params)
        @candidate.election = Election.last
        if @candidate.save
            redirect_to positionlist_path, notice: "El candidato fue añadido con exito"
        else
            render :newcandidate 
        end
    end

    def show
        @position = Position.find(params[:id])
    end

    def modifycandidate
        @candidate = Candidate.find(params[:id])
    end

    def updatecandidate
        @candidate = Candidate.update(params[:id], candidate_params)
        redirect_to positionlist_path
    end
    def deletecandidate
        @candidate = Candidate.find(params[:id])
        @candidate.destroy
        flash[:success] = "Eliminado"
        redirect_to positionlist_path
    end
    
private

    def position_params
        params.require(:position).permit(:name, :election_id, :group_id)
    end

    def candidate_params
        params.require(:candidate).permit(:name, :picture_url, :position_id, :election_id)
    end
end
