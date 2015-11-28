class AddDeletedAtToEvents < ActiveRecord::Migration
  def change
    add_column  :events, :deleted_at, :datetime,:null => true
    add_column  :events, :deleted_time, :integer,:null => true
    add_column  :events, :deleted_user, :integer,:null => true
  end
end
