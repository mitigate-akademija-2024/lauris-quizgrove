class QuizzesController < ApplicationController
  before_action :set_quiz, only: %i[show edit update destroy start submit results]
  before_action :ensure_quiz_has_questions, only: %i[start submit results]
  before_action :authenticate_user!, only: %i[new create edit update destroy]
  before_action :authorize_user!, only: %i[edit update destroy]
  # before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
 
  

  # GET /quizzes or /quizzes.json
  def index
    @quizzes = Quiz.all
    @title = 'These are the quizzes'
    @description = ''

    if params[:search].present?
      search_term = "%#{params[:search].downcase}%"
      @quizzes = Quiz.where("LOWER(title) LIKE ?", search_term)
    else
      @quizzes = Quiz.all
    end
end

  def find_anonymous_user
    # This could return a default user or create a new anonymous user record
    User.find_or_create_by(username: 'Anonymous')
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

  def scoreboard
    @scores = UserScore.where(quiz: @quiz).order(score: :desc)
  end  

# POST /quizzes/1/submit
def submit
  answers_params = params[:answers] || {}
  score = 0

  username = current_user ? current_user.username : 'Anonymous'
  @user_score = UserScore.create!(quiz: @quiz, username: username, score: 0)

  @quiz.questions.each do |question|
    selected_answer_id = answers_params[question.id.to_s]
    answer = question.answers.find_by(id: selected_answer_id)

    UserAnswer.create!(
      user_score: @user_score,
      question: question,
      answer: answer
    )

    score += 1 if answer&.correct
  end

  @user_score.update(score: score)

  if @user_score.save
    redirect_to results_attempt_quiz_path(@quiz, attempt_id: @user_score.id)
  else
    redirect_to start_quiz_path(@quiz), alert: "There was an error recording your score."
  end
end


  # GET /quizzes/1 or /quizzes/1.json
  def show
  end 

    # GET /quizzes/:id/results
    def results
      @quiz = Quiz.find(params[:id])
      @user_score = @quiz.user_scores.find_by(id: params[:attempt_id])
    
      if @user_score.nil?
        redirect_to quizzes_path, alert: "No results found for this quiz."
      else
        @results = @user_score.user_answers.includes(:question, :answer)
      end
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
    @quiz = current_user.quizzes.new(quiz_params)  # Ensure user association here

    if @quiz.save
      redirect_to quiz_url(@quiz), notice: "Quiz was successfully created."
    else
      render :new, status: :unprocessable_entity
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
    @quiz = Quiz.find(params[:id])
    if @quiz.destroy
      redirect_to quizzes_path, notice: 'Quiz was successfully deleted.'
    else
      redirect_to quizzes_path, alert: 'Error deleting quiz. Please check the data constraints.'
    end
  rescue ActiveRecord::RecordNotFound
    redirect_to quizzes_path, alert: 'Quiz not found.'
  end


  def export_results
  @quiz = Quiz.find(params[:id])
  @results = @quiz.user_scores

  respond_to do |format|
    format.csv { send_data generate_csv(@results), filename: "quiz_results_#{@quiz.id}.csv" }
    format.html { redirect_to @quiz, notice: "Results exported successfully." }
  end
end

private

def generate_csv(results)
  CSV.generate(headers: true) do |csv|
    csv << ["User", "Score", "Date"]

    results.each do |result|
      csv << [result.user.name, result.score, result.created_at]
    end
  end
end

  private

  def authorize_user!
    redirect_to quizzes_path, alert: "Not authorized" unless @quiz.user == current_user
  end
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def ensure_quiz_has_questions
      if @quiz.questions.empty?
        redirect_to quizzes_path, alert: "This quiz has no questions."
      end
    end

    # Only allow a list of trusted parameters through.
    def quiz_params
      params.require(:quiz).permit(:title, :description)
    end
end