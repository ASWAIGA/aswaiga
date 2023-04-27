class CreateIssueVersions < ActiveRecord::Migration[7.0]
  def change
    create_table :issue_versions do |t|
      t.references :issue, null: false, foreign_key: true
      t.string :attribute_name
      t.string :old_value
      t.string :new_value
      t.datetime :created_at_change

      t.timestamps
    end
  end
end
