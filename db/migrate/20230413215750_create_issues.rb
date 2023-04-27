class CreateIssues < ActiveRecord::Migration[7.0]
  def change
    create_table :issues do |t|
      t.string :tipus
      t.string :severity
      t.string :priority
      t.string :issue
      t.string :status
      t.string :assign_to
      t.date :due_date
      t.string :reason_due_date

      t.timestamps
    end
  end
   def change
     add_column :issues, :created_by, :string
     add_column :issues, :assignee, :string
  end

end