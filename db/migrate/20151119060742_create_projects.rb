class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.integer   :sales_user_id, :null => false
      t.integer   :company_id,  :null => false
      t.string    :name,        :null => false
      t.string    :url,         :null => false
      t.integer   :page_type,   :null => false
      t.string    :title
      t.text      :description
      t.text      :ogp_description
      t.datetime  :start_at
      t.datetime  :finish_at
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
