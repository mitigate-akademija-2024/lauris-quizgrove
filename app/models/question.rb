class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  has_many :answers
  accepts_nested_attributes_for :answers
end