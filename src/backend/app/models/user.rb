class User < ApplicationRecord
  has_secure_password
  has_many :email_campaigns
end
