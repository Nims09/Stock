class AddTagIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tag_id, :integer
  end
end
