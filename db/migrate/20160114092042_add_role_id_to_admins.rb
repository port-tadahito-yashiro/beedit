class AddRoleIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :role_id, :integer, after: :department_id
  end
end
