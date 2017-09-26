class AddCurrentAccessTokenToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :current_access_token, :string
  end
end
