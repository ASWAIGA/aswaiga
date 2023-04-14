class AddReasonBlockAndBlockStatusToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :reason_block, :string
    add_column :issues, :block_status, :boolean
  end
end
