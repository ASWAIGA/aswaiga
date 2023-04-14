class AddReasonBlock < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :reason_block, :string
  end
end
