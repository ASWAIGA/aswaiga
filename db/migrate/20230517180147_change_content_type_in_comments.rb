class ChangeContentTypeInComments < ActiveRecord::Migration[7.0]
  def change
    change_column :comments, :content, :string
  end
end
