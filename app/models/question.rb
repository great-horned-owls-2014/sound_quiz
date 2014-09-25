class Question < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :right_answer, class: "Track" #alias as right answer
  has_many :wrongchoices
end
