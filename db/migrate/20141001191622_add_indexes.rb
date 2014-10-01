class AddIndexes < ActiveRecord::Migration
  def change
    add_index :artists, :itunes_id
    add_index :questions, :track_id
    add_index :questions, :quiz_id
    add_index :quizzes, :artist_id
    add_index :taken_quizzes, :user_id
    add_index :taken_quizzes, :quiz_id
    add_index :taken_quizzes, :artist_id
    add_index :tracks, :name
    add_index :tracks, :artist_id
    add_index :tracks, :itunes_track_id
    add_index :user_answers, :user_id
    add_index :user_answers, :question_id
    add_index :user_answers, :track_id
    add_index :users, :email
    add_index :wrong_choices, :track_id
    add_index :wrong_choices, :question_id
  end
end
