class Quiz < ActiveRecord::Base
  belongs_to :artist
  has_many :questions
end
