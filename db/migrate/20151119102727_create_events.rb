class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|

      t.string :name, :null => true
      t.datetime :start_at, :null => true
      t.datetime :finish_at, :null => true
      t.string :color, :null => true
      t.integer :allDay, :null => true

      t.datetime :created_at, :null => false
      t.integer :created_time, :null => false
      t.integer :created_user, :null => false, :default => 1
      t.datetime :deleted_at, :null => true
      t.integer :deleted_time, :null => true
      t.integer :deleted_user, :null => true
      t.datetime :updated_at, :null => false
      t.integer :updated_time, :null => false
      t.integer :updated_user, :null => false, :default => 1
    end
  end
end
