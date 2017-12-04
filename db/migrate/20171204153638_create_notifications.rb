class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :name
      t.references :agency, foreign_key: true
      t.integer "agency_id"
      t.timestamps
    end
  end
end
