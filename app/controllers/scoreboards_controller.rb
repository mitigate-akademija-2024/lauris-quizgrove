class ScoreboardsController < ApplicationController
    def index
      @scores = UserScore.total_scores
    end
  end