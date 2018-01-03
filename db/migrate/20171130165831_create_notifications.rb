class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :name
      t.string :created_by

      t.timestamps
    end
  end
end
