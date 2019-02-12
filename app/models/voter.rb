class Voter < ApplicationRecord
  validates_uniqueness_of :identification
  belongs_to :election
  belongs_to :group
  validates :group_id, :identification, presence: true
end
