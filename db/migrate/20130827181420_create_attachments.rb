class CreateAttachments < ActiveRecord::Migration
  def up
    create_table :attachments do |t|
      t.string :asset
      t.references :issue

      t.timestamps
    end

    remove_column :issues, :asset
  end

  def down
    drop_table :attachments
    add_column :issues, :asset, :string
  end

end
