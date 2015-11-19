class CreateSupers < ActiveRecord::Migration
  def change
    create_table :supers do |t|
      t.string :name, :null => false
      t.string :password, :null => false
      t.string :salt,     :null => false
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
