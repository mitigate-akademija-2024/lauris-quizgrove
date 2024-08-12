Rails.application.routes.draw do
  root 'welcome#index'  # Sets the root path to the welcome page

  resources :quizzes do
    member do
      get 'start'   # Route to start the quiz
      post 'submit' # Route to submit the quiz
      get 'results' # Route for the results page
    end

    resources :questions, shallow: true
    get 'continue', on: :member
    get 'completed', on: :collection
  end

  # Additional routes if needed
  get 'welcome/index' # Ensure this route exists
  get 'questions/index'
  get 'questions/start'
  get 'questions/test'
  get 'quizzes/results', to: 'quizzes#results', as: 'results'
  get "up" => "rails/health#show", as: :rails_health_check
end
