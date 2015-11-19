class AddEmailToSupers < ActiveRecord::Migration
  def change
    add_column :supers, :email, :string, :after => :name
  end
end
