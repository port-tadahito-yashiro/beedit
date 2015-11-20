class RemoveCreatedAtFromEvents < ActiveRecord::Migration
  def change
    remove_column :events, :created_at, :datetime
    remove_column :events, :created_time, :integer
    remove_column :events, :created_user, :integer
    remove_column :events, :deleted_at, :datetime
    remove_column :events, :deleted_time, :integer
    remove_column :events, :deleted_user, :integer
    remove_column :events, :updated_at, :datetime
    remove_column :events, :updated_time, :integer
    remove_column :events, :updated_user, :integer

  end
end
