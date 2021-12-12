class CreateMails < ActiveRecord::Migration[5.1]
  def change
    create_table :mails, id: :uuid do |t|
      t.references :client, type: :uuid, index: true, foreign_key: {to_table: :clients}
      t.references :email_campaign, type: :uuid, index: true, foreign_key: {to_table: :email_campaigns}
      t.datetime :created_at
    end
  end
end
