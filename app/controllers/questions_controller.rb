class QuestionsController < ApplicationController
  def index
  end

  def create
    @question = @quiz.question.new(question_attributes)
    if @question.save
      flash.notice = "Question was successfully created"
      redirect_to quiz_url(@quiz)
  end

  def new
    @quiz = Quiz.find(params[:quiz_id])
    @question = @quiz.questions.new
  end

private

def set_quiz
    @quiz = Quiz.find(params[:quiz_id])
  end

def question_attributes
  params.require(:question).permit(:question_text)  
end
