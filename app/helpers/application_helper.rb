module ApplicationHelper
    def votes_per_position(position_id)
        Vote.where(position: Position.find(position_id))
    end
    def candidates_per_position(position_id)
        Candidate.where(position: position_id)
    end
    def votes_per_candidate(candidate)
        Vote.where(candidate: candidate)
    end
    def position_by_group(group_id)
        Position.where(group: group_id)
    end
    def voters_by_group(group_id)
        Voter.where(group: group_id)
    end
    def group_of_a_code(code_id)
        Group.find(Voter.find_by(code_id: code_id).group_id)
    end
    def user_by_id(id)
        User.find(id)
    end
end
