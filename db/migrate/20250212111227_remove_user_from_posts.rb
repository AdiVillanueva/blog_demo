class RemoveUserFromPosts < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :posts, :users, if_exists: true
    remove_index :posts, :user_id, if_exists: true
    remove_column :posts, :user_id, :bigint, if_exists: true
  end
end
