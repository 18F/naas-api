class ChangeUserIndex < ActiveRecord::Migration[5.1]
  def change
    remove_column :notification_events, :user_subscription_id
    add_reference :notification_events, :user, index: true
  end
end
