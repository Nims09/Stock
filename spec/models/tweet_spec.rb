# == Schema Information
#
# Table name: tweets
#
#  id             :integer          not null, primary key
#  favorite_count :integer
#  filter_level   :text
#  retweet_count  :integer
#  text           :text
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  tweeted_at     :datetime
#  tag_id         :integer
#  sentiment      :string
#

require 'rails_helper'

RSpec.describe Tweet, type: :model do
	describe "validates" do 
		it "has a valid factory" do
			expect(FactoryGirl.create(:tweet)).to be_valid
		end

		it "is invalid without a text" do 
			expect(FactoryGirl.build(:tweet, text: nil)).not_to be_valid
		end

		it "is invalid without a tweeted_at" do 
			expect(FactoryGirl.build(:tweet, tweeted_at: nil)).not_to be_valid
		end

		it "is invalid without a tag_id" do 
			expect(FactoryGirl.build(:tweet, tag_id: nil)).not_to be_valid
		end

		it "is invalid without a sentiment" do 
			expect(FactoryGirl.build(:tweet, sentiment: nil)).not_to be_valid
		end

		it "is invalid without a valid sentiment" do 
			expect(FactoryGirl.build(:tweet, sentiment: "INVALID")).not_to be_valid
		end
	end

	describe "#determine_sentiment" do 
		before(:each) do
			@tweet = FactoryGirl.create(:tweet)
		end

		it "will set to negative" do 
			@tweet.text = "i am sad"

			@tweet.determine_sentiment
			
			expect(@tweet.sentiment).to eq "negative"
		end

		it "will set to positive" do 
			@tweet.text = "i am happy"

			@tweet.determine_sentiment
			
			expect(@tweet.sentiment).to eq "positive"			
		end

		it "will set to neutral" do 
			@tweet.text = "i am ok"

			@tweet.determine_sentiment
			
			expect(@tweet.sentiment).to eq "neutral"			
		end
	end
end
