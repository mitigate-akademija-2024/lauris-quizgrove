class QuestionsController < ApplicationController
  before_action :set_quiz, only: [:new, :create]

  def index
  end

  def create
    @question = @quiz.questions.new(question_params)

    @question.answers.new answer_text: params[:question][:answer1]
    @question.answers.new answer_text: params[:question][:answer2]
    @question.answers.new answer_text: params[:question][:answer3]

    if @question.save
      flash.notice = "Question was successfully created."
      redirect_to quiz_url(@quiz)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def new
    @question = @quiz.questions.new
    @question.answers.new
    @question.answers.new
    @question.answers.new
  end

  private

  def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

  def question_params
    params.require(:question).permit(:question_text)
  end
end
