class Code < ApplicationRecord
    has_many :votes, dependent: :destroy
    validates :code, presence: true

end
