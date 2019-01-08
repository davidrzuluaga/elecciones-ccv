class Candidate < ApplicationRecord
  belongs_to :position
  belongs_to :group
  belongs_to :election
end
