class Vote < ApplicationRecord
  belongs_to :candidate
  belongs_to :code
  belongs_to :position
end
