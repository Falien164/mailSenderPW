class DropTableTasks < ActiveRecord::Migration[5.1]
  def change
    drop_table :tasks, force: :cascade do |t|
      t.text :Description
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
  end
end
