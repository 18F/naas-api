class ChangeNameOfRead < ActiveRecord::Migration[5.1]
  def change
    rename_column :notification_events, :read, :unread
  end
end
