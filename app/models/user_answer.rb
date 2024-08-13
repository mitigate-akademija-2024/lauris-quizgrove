class UserAnswer < ApplicationRecord
  belongs_to :user_score
  belongs_to :question
  belongs_to :answer
end
