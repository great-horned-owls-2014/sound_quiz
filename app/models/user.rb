require 'bcrypt'

class User < ActiveRecord::Base
  has_many :user_answers
  has_secure_password #takes care of password prescence validation

  # validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
  validates_uniqueness_of :email
  validates_presence_of :username
end

