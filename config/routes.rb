# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'welcome#index'

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

  get 'scoreboard', to: 'scoreboards#index'

  # Additional routes
  get 'welcome/index'
  get 'welcome/login_index', to: 'welcome#login_index', as: 'login_index'
  get 'questions/index'
  get 'questions/start'
  get 'questions/test'
  get 'quizzes/results', to: 'quizzes#results', as: 'results'
  get 'quizzes/:id/results/:attempt_id', to: 'quizzes#results', as: 'results_attempt_quiz'
  get 'up' => 'rails/health#show', as: :rails_health_check

  get 'dashboard', to: 'welcome#login_index'
end
