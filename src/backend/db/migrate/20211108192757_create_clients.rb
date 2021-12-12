class CreateClients < ActiveRecord::Migration[5.1]
  def change
    create_table :clients, id: :uuid do |t|
      t.string :email
      t.string :name
      t.string :surname
      t.references :email_campaign, type: :uuid, index: true, foreign_key: {to_table: :email_campaigns, on_delete: :cascade}
      t.datetime :created_at
    end
  end
end
