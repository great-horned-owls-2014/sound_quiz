class CreateTakenQuizzes < ActiveRecord::Migration
  def change
    create_table :taken_quizzes do |t|
      t.belongs_to :user
      t.belongs_to :quiz
      t.references :artist
      t.integer :time
      t.integer :score
      t.timestamps
    end
  end
end
