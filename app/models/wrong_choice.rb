class WrongChoice < ActiveRecord::Base
  belongs_to :question
  belongs_to :track
end
