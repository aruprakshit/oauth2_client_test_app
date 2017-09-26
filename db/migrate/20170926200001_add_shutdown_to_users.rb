class AddShutdownToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :shutdown, :boolean, default: false
  end
end
