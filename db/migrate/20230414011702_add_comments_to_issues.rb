class AddCommentsToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :comments, :text
  end
end
