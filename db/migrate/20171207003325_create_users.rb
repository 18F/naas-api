class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :middle_name
      t.integer :phone
      t.references :notification, foreign_key: true

      t.timestamps
    end
  end
end
