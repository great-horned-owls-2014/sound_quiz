class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :artist
      t.integer :difficulty_level

      t.timestamps
    end
  end
end
