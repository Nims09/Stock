class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.integer :favorite_count
      t.text :filter_level
      t.integer :retweet_count
      t.text :text
      t.datetime :created_at

      t.timestamps null: false
    end
  end
end
