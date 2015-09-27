# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string
#  sentiment  :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'
require './spec/support/tweet_helpers'

RSpec.configure do |c|
  c.include TweetHelpers
end

describe Tag, :type => :model do 

	describe "validates" do 

		it "has a valid factory" do 
			expect(FactoryGirl.create(:tag)).to be_valid
		end 

	end

	describe "#intiate_sentiment" do

		before(:each) do 
			@tag_name = "#justin"

			@tag = FactoryGirl.create(:tag, name: @tag_name)

			@now = Time.parse("1969-07-20 20:17:40")
			allow(Time).to receive(:now).and_return(@now)


			allow(@tag).to receive(:get_tweets_in_time_range).and_return(unprocessed_tweets(3, @tag_name, @now-1.weeks, @now))			
		end

		it "has a helper for generated unprocessed tweets" do 
			start_date = '2015-09-12 2:31:32 +0'
			end_date = '2015-09-13 2:31:32 +0000'

			tweets = unprocessed_tweets(3, @tag_name, start_date, end_date)

			expect(tweets.size).to eq 3
			expect(tweets.first.favorite_count).to eq "3"
			expect(tweets.first.created_at).to eq start_date
			expect(tweets.last.created_at).to eq end_date
			expect(tweets.last.text).to eq @tag_name
		end


		it "makes a call for tweets" do 
			expect(@tag).to receive(:get_tweets_in_time_range).with(@tag_name, (@now-1.weeks), @now)

			@tag.intiate_sentiment
		end 

		it "saves a correct tweet" do 
			allow_any_instance_of(Tweet).to receive(:save).and_return(true)			
				
			expect(@tag).not_to receive(:dispatch_error).with("Failed to save tweet")

			@tag.intiate_sentiment
		end

		it "calls an error on an failed to save tweet" do
			allow_any_instance_of(Tweet).to receive(:save).and_return(false)			
				
			expect(@tag).to receive(:dispatch_error).with("Failed to save tweet").at_least(:once)

			@tag.intiate_sentiment
		end

		it "saves the parent ID" 

	end

	describe "#get_tweets_in_time_range" do
		# TODO : Fill me in. 
	end

end 