class Group < ApplicationRecord
  belongs_to :election
  has_many :positions, dependent: :destroy
  has_many :voters, dependent: :destroy
  validates :name, presence: true
end
