class Track < ActiveRecord::Base

  has_many :user_answers
  has_one :question
  belongs_to :artist

end
