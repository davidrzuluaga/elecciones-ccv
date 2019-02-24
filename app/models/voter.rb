class Voter < ApplicationRecord
  validates_uniqueness_of :identification
  belongs_to :election
  belongs_to :group
  belongs_to :code
  validates :group_id, :identification, presence: true

end
