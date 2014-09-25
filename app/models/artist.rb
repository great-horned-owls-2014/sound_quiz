class Artist < ActiveRecord::Base
  has_many :tracks
  has_many :quizzes
end
