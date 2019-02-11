class GroupController < ApplicationController
  before_action :adminPermit

    def index
        @groups = Group.all
    end
    def new
        @group = Group.new
    end
    def create
        @group = Group.new(group_params)
        @group.election = Election.last
        if @group.save
            redirect_to groups_path, notice: "El grupo fue creado con exito"
        else
            render :new 
        end
    end

    def show
        @group = Group.find(params[:id])
        @positions = Position.where(group: params[:id])
        @voters = Voter.where(group: params[:id])
    end

    def modify
        @group = Group.find(params[:id])
    end

    def update
        @group = Group.update(params[:id], group_params)
        redirect_to groups_path
    end

    def delete
        @group = Group.find(params[:id])
        @group.destroy
        flash[:success] = "Eliminado"
        redirect_to groups_path
    end

    private

    def group_params
        params.require(:group).permit(:name)
    end
end
