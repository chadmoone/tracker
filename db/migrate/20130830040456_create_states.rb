class CreateStates < ActiveRecord::Migration
  def change
    create_table :states do |t|
      t.string :name
      t.string :color
      t.string :background

      t.timestamps
    end

    add_column :issues, :state_id, :integer
    add_index :issues, :state_id

    add_column :comments, :state_id, :integer
  end
end
