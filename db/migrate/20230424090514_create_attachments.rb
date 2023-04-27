class CreateAttachments < ActiveRecord::Migration[7.0]
  def change
    create_table :attachments do |t|
      t.references :issue, null: false, foreign_key: true
      t.timestamps
    end

    add_column :attachments, :file, :string
    add_index :attachments, :file, unique: true
  end
end
