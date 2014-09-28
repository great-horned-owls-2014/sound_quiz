class TakenQuiz < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :user
end
