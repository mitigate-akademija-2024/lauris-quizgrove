Rails.application.routes.draw do
  get 'questions/index'
  get 'questions/start'
  get 'questions/test'

  root 'quizzes#index'

  resources :quizzes do
    member do
      get 'start'   # Route to start the quiz (view questions)
      post 'submit' # Route to submit the quiz (evaluate answers)
    end

    resources :questions, shallow: true

    get 'continue', on: :member
    get 'completed', on: :collection
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
