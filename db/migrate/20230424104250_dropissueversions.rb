class Dropissueversions < ActiveRecord::Migration[7.0]
  def change
    drop_table :issue_versions
  end
end
