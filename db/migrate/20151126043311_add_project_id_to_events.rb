class AddProjectIdToEvents < ActiveRecord::Migration
  def change
    add_column :events, :project_id, :integer, :null => true,:after => :id
  end
end
