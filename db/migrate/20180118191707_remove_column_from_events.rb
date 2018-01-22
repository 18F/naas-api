class RemoveColumnFromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :notification_events, :user_subscriptions_id
  end
end
