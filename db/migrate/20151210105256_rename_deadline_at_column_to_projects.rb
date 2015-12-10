class RenameDeadlineAtColumnToProjects < ActiveRecord::Migration
  def change
    rename_column :projects, :deadline_at, :domain_deadline_at
    rename_column :projects, :deadline_time, :domain_deadline_time
  end
end
