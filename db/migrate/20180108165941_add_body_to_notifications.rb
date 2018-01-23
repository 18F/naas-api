class AddBodyToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :body, :text
  end
end
