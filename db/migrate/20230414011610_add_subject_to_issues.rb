class AddSubjectToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :subject, :string
  end
end
