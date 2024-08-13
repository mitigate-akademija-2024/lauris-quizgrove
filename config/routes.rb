Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'  # Sets the root path to the welcome page

  resources :quizzes do
    member do
      get 'start'
      post 'submit'
      get 'results'
      get 'export_results'
    end

    resources :questions, shallow: true
    get 'continue', on: :member
    get 'completed', on: :collection
  end

  # Additional routes if needed
  get 'welcome/index'
  get 'questions/index'
  get 'questions/start'
  get 'questions/test'
  get 'quizzes/results', to: 'quizzes#results', as: 'results'
  get "up" => "rails/health#show", as: :rails_health_check
  get 'quizzes/:id/results/:attempt_id', to: 'quizzes#results', as: 'results_attempt_quiz'
end