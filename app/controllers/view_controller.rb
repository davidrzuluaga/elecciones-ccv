class ViewController < ApplicationController
  before_action :viewPermit

  def index
    autenticated = User.find_by(logincode: cookies.signed[:session]["code"])
    @autenticated = autenticated.role if autenticated  
    @group = Group.all
    @positions = Position.order('name asc').paginate :page => params[:page], :per_page => 3
  end

  def show
    candidates = {}
    Vote.where(candidate: Candidate.where(position: Position.find(params[:id]))).each { |vote| candidates[Candidate.find(vote.candidate_id).name] = 0 }
    Vote.where(candidate: Candidate.where(position: Position.find(params[:id]))).each do |vote|
      candidates[Candidate.find(vote.candidate_id).name] = candidates[ Candidate.find(vote.candidate_id).name] += 1
    end
    @chart = candidates
    @position = Position.find(params[:id])
    @chart
  end
end
