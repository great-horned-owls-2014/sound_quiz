class Track < ActiveRecord::Base
  has_many :useranswers
  has_one :question
  belongs_to :artist

end
