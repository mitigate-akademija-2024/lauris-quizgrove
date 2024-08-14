# frozen_string_literal: true

json.array! @quizzes, partial: 'quizzes/quiz', as: :quiz
