class ViewController < ApplicationController
  before_action :viewPermit

  def index
    code = Auth.find_by(sessioncode: cookies.signed[:session]["code"])
    autenticated = User.find(code.user_id)
    @autenticated = autenticated.role if autenticated  
    @positions = Position.order('name asc')
  end
  
  def show
    candidates = {}
    @votesbyhour = {}
    @votesbyday = {}
    @position = Position.find(params[:id])
    Vote.where(candidate: Candidate.where(position: @position.id)).each { |vote| candidates[Candidate.find(vote.candidate_id).name] = 0 }
    Vote.where(candidate: Candidate.where(position: @position.id)).each do |vote|
      candidates[Candidate.find(vote.candidate_id).name] = candidates[ Candidate.find(vote.candidate_id).name] += 1
    end
    votesbyhour = Vote.where(candidate: Candidate.where(position: @position.id)).group_by_hour_of_day(:created_at).count
    votesbyhour.each {|v, i| @votesbyhour[v] = i if i != 0}
    votesbyday = Vote.where(candidate: Candidate.where(position: @position.id)).group_by_day_of_month(:created_at).count
    votesbyday.each {|v, i| @votesbyday[v] = i if i != 0} 
    @chart = candidates
  end
end
