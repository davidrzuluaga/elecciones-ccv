class Position < ApplicationRecord
  belongs_to :group
  has_many :candidates, dependent: :destroy
  has_many :votes, dependent: :destroy
  validates :name, :group_id, presence: true
end
