class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.belongs_to :artist
      t.integer :level

      t.timestamps
    end
  end
end
