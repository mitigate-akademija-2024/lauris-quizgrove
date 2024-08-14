# frozen_string_literal: true

class Answer < ApplicationRecord
  validates :answer_text, presence: true

  has_many :user_answers
  belongs_to :question
end
