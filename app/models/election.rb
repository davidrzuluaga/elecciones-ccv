class Election < ApplicationRecord
    has_many :position, dependent: :destroy
    has_many :voters, dependent: :destroy
    has_many :candidates, dependent: :destroy
    has_many :groups, dependent: :destroy
    validates :year, presence: true

end
