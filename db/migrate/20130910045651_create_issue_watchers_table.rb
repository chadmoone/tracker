class CreateIssueWatchersTable < ActiveRecord::Migration
  def change
    create_table :issue_watchers, id: false do |t|
      t.integer :user_id, :issue_id
    end
  end
end
