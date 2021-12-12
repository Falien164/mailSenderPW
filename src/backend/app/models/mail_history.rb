class MailHistory < ApplicationRecord
  belongs_to :email_campaign
  belongs_to :client
end
