class Code < ApplicationRecord
    has_many :votes, dependent: :destroy
    has_many :voters, dependent: :nullify
    validates :code, presence: true
end
