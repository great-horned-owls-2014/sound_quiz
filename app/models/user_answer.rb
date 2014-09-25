class UserAnswer < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_decision, class: "Track" #alias user_decision
  belongs_to :question

end
