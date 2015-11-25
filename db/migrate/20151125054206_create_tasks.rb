class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|

      t.integer   :admin_id
      t.string    :title
      t.text      :context
      t.integer   :state
      t.datetime  :finish_at,    :null => true
      t.datetime  :start_at,     :null => true
      t.datetime  :created_at,   :null => false
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
