class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.integer :phone

      t.timestamps
    end
  end
end
