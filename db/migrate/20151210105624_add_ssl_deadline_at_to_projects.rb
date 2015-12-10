class AddSslDeadlineAtToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ssl_deadline_at, :datetime, :after => :domain_deadline_time
    add_column :projects, :ssl_deadline_time, :integer, :after => :ssl_deadline_at
  end
end
