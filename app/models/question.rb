# frozen_string_literal: true

class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  has_many :answers, dependent: :destroy
  has_many :user_answers, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes|
                                                                            attributes['answer_text'].blank?
                                                                          }
end
