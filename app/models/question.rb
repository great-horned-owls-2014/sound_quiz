class Question < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :right_answer, class_name: :Track , foreign_key: "track_id"
  has_many :wrong_choices
  has_many :user_answers
end
