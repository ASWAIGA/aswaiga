class AddDescriptionToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :description, :string
  end
end
