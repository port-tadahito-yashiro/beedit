class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|

      t.string :name, :null => false
      t.text :description, :null => false
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
