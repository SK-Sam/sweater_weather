class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key
  
  validates_presence_of :email, :password_digest
  validates_uniqueness_of :email
end
