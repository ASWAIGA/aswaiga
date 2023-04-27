class AddUserNameToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :user_name, :string
  end
end
