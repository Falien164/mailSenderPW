class ChangeMailsToMailHistories < ActiveRecord::Migration[5.1]
  def change
    rename_table :mails, :mail_histories
  end
end
