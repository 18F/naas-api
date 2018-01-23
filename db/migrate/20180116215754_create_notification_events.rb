class CreateNotificationEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :notification_events do |t|
      t.text :body
      t.boolean :read
      t.references :user_subscriptions, foreign_key: true
      t.integer "user_subscription_id"

      t.timestamps

    end
  end
end
