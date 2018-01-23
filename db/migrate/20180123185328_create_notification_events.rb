class CreateNotificationEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_events do |t|
      t.text :body
      t.boolean :unread
      t.references :users, foreign_key: true
      t.integer "user_id"

      t.timestamps

    end
  end
end