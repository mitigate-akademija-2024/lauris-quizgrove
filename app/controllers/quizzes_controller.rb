class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[ show edit update destroy start submit ]

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all
    @title = 'These are the quizzes'
    @description = 'lorem ipsum'
  end

  # GET /quizzes/1/start
  def start
    @title = 'Start some quiz'
    @description = 'Something'
    @questions = @quiz.questions.includes(:answers)  # Load questions and their answers for the quiz

    respond_to do |format|
      format.html
      format.json do
        render json: { title: @title, description: "Šī ir json atbilde" }
      end
    end
  end

  # POST /quizzes/1/submit
  def submit
    user_answers = params[:answers] || {}
    @correct_answers_count = 0

    @quiz.questions.each do |question|
      correct_answer = question.answers.find_by(correct: true)&.id
      user_answer = user_answers[question.id.to_s].to_i

      if correct_answer == user_answer
        @correct_answers_count += 1
      end
    end

    flash.notice = "You answered #{@correct_answers_count} out of #{@quiz.questions.count} questions correctly."
    redirect_to quizzes_path
  end

  # GET /quizzes/1 or /quizzes/1.json
  def show
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
  end

  # GET /quizzes/1/edit
  def edit
  end

  # POST /quizzes or /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html do
          flash.notice = "Quiz was successfully created."
          redirect_to quiz_url(@quiz)
        end
        format.json { render :show, status: :created, location: @quiz }
      else
        flash.now.alert = 'Something went wrong'
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1 or /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to quiz_url(@quiz), notice: "Quiz was successfully updated." }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1 or /quizzes/1.json
  def destroy
    @quiz.destroy!

    respond_to do |format|
      format.html { redirect_to quizzes_url, notice: "Quiz was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:title, :description)
    end
end