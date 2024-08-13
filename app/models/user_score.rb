class UserScore < ApplicationRecord
    belongs_to :quiz
    has_many :user_answers, dependent: :destroy
  end