# frozen_string_literal: true

class ScoreboardsController < ApplicationController
  def index
    @scores = UserScore.total_scores
  end

  def export
    @scores = UserScore.total_scores

    respond_to do |format|
      format.csv { send_data generate_csv(@scores), filename: "scoreboard_#{Time.zone.today}.csv" }
    end
  end

  private

  def generate_csv(scores)
    CSV.generate(headers: true) do |csv|
      csv << %w[Rank Username TotalScore]

      scores.each_with_index do |score, index|
        csv << [index + 1, score.username, score.total_score]
      end
    end
  end
end
