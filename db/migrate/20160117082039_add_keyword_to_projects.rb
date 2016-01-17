class AddKeywordToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :keyword,       :string, null: true, after: :ogp_description
    add_column :projects, :thanks_title,  :string, null: true, after: :keyword
    add_column :projects, :thanks_text,   :text,   null: true, after: :thanks_title
    add_column :projects, :mail_title,    :string, null: true, after: :thanks_text
    add_column :projects, :mail_text,     :text,   null: true, after: :mail_title
    add_column :projects, :personal_info, :text,   null: true, after: :mail_text
  end
end
