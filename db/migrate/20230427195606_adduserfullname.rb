class Adduserfullname < ActiveRecord::Migration[7.0]
  def change
    add_column :issue_versions, :user_full_name, :string
  end
end
