class AddTableNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :table_name, :string, :null => true, :after => :name
  end
end
