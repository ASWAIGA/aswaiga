class AddNewColumnToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :assignee, :string
  end
end
