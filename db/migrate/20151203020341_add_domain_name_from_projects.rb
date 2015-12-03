class AddDomainNameFromProjects < ActiveRecord::Migration
  def change
    add_column :projects, :domain_name, :string, :null => true, :after => :finish_at
    add_column :projects, :deadline_at, :datetime, :null => true, :after => :domain_name
    add_column :projects, :deadline_time, :integer, :null => true, :after => :deadline_at
  end
end
