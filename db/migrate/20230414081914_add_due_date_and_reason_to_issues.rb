class AddDueDateAndReasonToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :due_date, :date
    add_column :issues, :reason_due_date, :string
  end
end
