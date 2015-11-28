class AddDepartmentIdToAdmins < ActiveRecord::Migration
  def change
    add_column :admins, :department_id, :integer, :null => false,:after => :id
  end
end
