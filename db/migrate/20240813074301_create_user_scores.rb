# frozen_string_literal: true

class CreateUserScores < ActiveRecord::Migration[7.1]
  def change
    create_table :user_scores do |t|
      t.integer :quiz_id, null: false
      t.string :username, null: false
      t.integer :score, null: false

      t.timestamps
    end

    add_index :user_scores, :quiz_id
  end
end
