class AddLoginUidToUser < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :login_uid, :string
  end
end
