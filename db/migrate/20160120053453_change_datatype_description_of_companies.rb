class ChangeDatatypeDescriptionOfCompanies < ActiveRecord::Migration
  def change
    change_column_null :companies, :description, true
  end
end
