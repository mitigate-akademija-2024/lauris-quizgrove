    class UserScore < ApplicationRecord
        belongs_to :quiz
        has_many :user_answers, dependent: :destroy

        validates :username, presence: true
        validates :score, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

        def self.total_scores
            select('username, SUM(score) as total_score')
            .group('username')
            .order('total_score DESC')
            # .limit(10)
        end
    end