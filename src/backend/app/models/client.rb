class Client < ApplicationRecord
  belongs_to :email_campaign
  has_many :mail_histories, dependent: :nullify

  validates :email, :name, :surname, presence: true
end
