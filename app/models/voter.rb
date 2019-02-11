class Voter < ApplicationRecord
  belongs_to :election
  belongs_to :group
  validates :group_id, :identification, presence: true

end
