class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string    :name
      t.text      :description
      t.string    :password,  :null => true
      t.string    :email,     :null => true
      t.string    :salt,      :null => true

      t.datetime  :created_at,  :null => false
      t.integer   :created_time, :null => false
      t.integer   :created_user, :null => false, :default => 1
      t.datetime  :deleted_at,   :null => true,  :default => nil
      t.integer   :deleted_time, :null => true,  :default => nil
      t.integer   :deleted_user, :null => true,  :default => nil
      t.datetime  :updated_at,   :null => false
      t.integer   :updated_time, :null => false
      t.integer   :updated_user, :null => false, :default => 1
    end
  end
end
