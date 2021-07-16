class Score < ApplicationRecord

  belongs_to :user
  belongs_to :character
  belongs_to :stage
  
end
