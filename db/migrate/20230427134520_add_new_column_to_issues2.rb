class AddNewColumnToIssues2 < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :created_by, :string
  end
end
