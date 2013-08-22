class AddAssetToIssues < ActiveRecord::Migration
  def change
    add_column :issues, :asset, :string
  end
end
