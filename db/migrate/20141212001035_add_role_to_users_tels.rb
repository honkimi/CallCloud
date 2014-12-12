class AddRoleToUsersTels < ActiveRecord::Migration
  def change
    add_column :user_tels, :role, :integer
  end
end
