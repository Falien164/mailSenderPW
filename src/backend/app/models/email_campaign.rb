class EmailCampaign < ApplicationRecord
  has_many :clients, dependent: :destroy
  has_many :mail_histories, dependent: :destroy
  belongs_to :user

  validates :title, :description, :subject, :body, presence: true

  def send_to_new_clients
    client_ids = clients.where.not(id: mail_histories.pluck(:client_id))
    Api::MailSender.call(client_ids: client_ids, email_campaign_id: id)
  end
end
