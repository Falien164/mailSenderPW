class CreateEmailCampaigns < ActiveRecord::Migration[5.1]
  def change
    create_table :email_campaigns, id: :uuid do |t|
      t.string :title
      t.text :description
      t.string :subject
      t.text :body
      t.timestamps
    end
  end
end
