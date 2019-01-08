class Voter < ApplicationRecord
  belongs_to :election
  belongs_to :group
end
