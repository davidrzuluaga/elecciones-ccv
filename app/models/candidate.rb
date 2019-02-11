class Candidate < ApplicationRecord
  belongs_to :position
  belongs_to :election
  has_many :votes, dependent: :destroy
  validates :name, :picture_url, :position_id, presence: true

end
