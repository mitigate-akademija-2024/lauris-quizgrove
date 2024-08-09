class Question < ApplicationRecord
  validates :question_text, presence: true

  belongs_to :quiz
  has_many :answers, dependent: :destroy
  
  accepts_nested_attributes_for :answers, allow_destroy: true, reject_if: proc { |attributes| attributes ['answer_text'].blank?}

  validate :validate_answers

  private

  def validate_answers
    errors.add(:answers, :too_few, message: "at least two answers needed") if answers.count < 2
    errors.add(:answers, :too_few, message: "at least one correct answers needed") if answers.none? {|ans| ans.correct?}
  end


end