class Track < ActiveRecord::Base

	validates :name, uniqueness: true

  has_many :user_answers
  has_one :question
  belongs_to :artist

end
