class Candidate < ApplicationRecord
  belongs_to :position
  belongs_to :election
end
