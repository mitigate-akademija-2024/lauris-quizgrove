class AddForeignKeyToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_foreign_key :user_scores, :quizzes, on_delete: :cascade
  end
end
