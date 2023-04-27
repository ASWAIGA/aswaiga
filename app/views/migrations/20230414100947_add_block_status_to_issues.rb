class AddBlockStatusToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :block_status, :boolean
  end
end
