class User < ActiveRecord::Base
  has_many :user_answers
  has_secure_password

  # validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
end

