# frozen_string_literal: true

class User < ApplicationRecord
  has_many :quizzes, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Add validations
  validates :username, presence: true, uniqueness: true
end
