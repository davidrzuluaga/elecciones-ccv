class Auth < ApplicationRecord
  belongs_to :user
  validates :user_id, :sessioncode, :log, presence: true

end
