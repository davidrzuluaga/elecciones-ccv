class Candidate < ApplicationRecord
  belongs_to :group
  belongs_to :election
end
