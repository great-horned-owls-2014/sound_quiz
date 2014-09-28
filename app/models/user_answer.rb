class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_decision, class_name: :Track, foreign_key: "track_id"
  belongs_to :question
end
