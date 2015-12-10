class AddProjectIdFromTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :project_id, :integer, :after => :id
  end
end
