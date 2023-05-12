class CreateArxius < ActiveRecord::Migration[7.0]
  def change
    create_table :arxius do |t|
      t.references :issue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
