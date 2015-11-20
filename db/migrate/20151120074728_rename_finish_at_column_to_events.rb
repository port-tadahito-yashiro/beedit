class RenameFinishAtColumnToEvents < ActiveRecord::Migration
  def change
    rename_column :events, :finish_at, :end
    rename_column :events, :start_at, :start
  end
end
