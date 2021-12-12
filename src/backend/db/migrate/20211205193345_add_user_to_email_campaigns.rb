class AddUserToEmailCampaigns < ActiveRecord::Migration[5.1]
  def change
    add_reference :email_campaigns, :user, type: :uuid, index: true, foreign_key: {to_table: :users}
  end
end
