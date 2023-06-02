class AddUserIdToVersions < ActiveRecord::Migration[7.0]
  def change
    add_column :issue_versions, :userid, :int
  end
end
