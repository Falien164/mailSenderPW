class Api::MailSender
  include SendGrid
  class << self
    VARIABLE_REGEXP = /{{var:[\w-]+}}/.freeze

    def call(client_ids:, email_campaign_id:)
      email_campaign = EmailCampaign.find(email_campaign_id)

      Client.where(id: client_ids).each do |client|
        response = send_mail(client, email_campaign)
        create_mail_history(email_campaign.id, client.id) if response.status_code == "202"
      end
    end

    private

    def body(client, ec_body)
      ec_body.gsub(VARIABLE_REGEXP) { |var| client.try(var[6..-3].to_sym) }
    end

    def send_mail(client, email_campaign)
      from = SendGrid::Email.new(email: ENV['SENDGRID_SENDER_EMAIL'])
      to = SendGrid::Email.new(email: client.email)
      subject = email_campaign.subject
      content = SendGrid::Content.new(type: 'text/plain', value: body(client, email_campaign.body))
      mail = SendGrid::Mail.new(from, subject, to, content)

      sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
      sg.client.mail._('send').post(request_body: mail.to_json)
    end

    def create_mail_history(ec_id, client_id)
      MailHistory.create(email_campaign_id: ec_id, client_id: client_id,
                         created_at: Time.now)
    end
  end
end
