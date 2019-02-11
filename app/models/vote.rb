class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :code
  belongs_to :position
  validates :candidate_id, :code_id, presence: true

end
