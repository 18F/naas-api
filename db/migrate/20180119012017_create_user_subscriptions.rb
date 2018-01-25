class CreateUserSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :user_subscriptions do |t|
      t.string :name
      t.references :notification, foreign_key: true
      t.references :users, foreign_key: true
      t.integer "notification_id"
      t.integer "user_id"
      t.timestamps
    end
  end
end
