class User < ApplicationRecord
    has_secure_password validations: false
    validates :user, :password, :role, :logincode, presence: true
end
