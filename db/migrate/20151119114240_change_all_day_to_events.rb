class ChangeAllDayToEvents < ActiveRecord::Migration

  #変更後の型
  def up
    change_column :events, :allDay, :boolean, null: true
  end

  #変更前の型
  def down
    change_column :events, :allDay, :integer, null: true
  end
end
