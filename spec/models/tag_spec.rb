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

RSpec.describe Tag, type: :model do 

	describe "validates" do 

		it "has a valid factory" do 
			expect(FactoryGirl.create(:tag)).to be_valid
		end 

		it "is invalid without a name" do 
			expect(FactoryGirl.build(:tag, name: nil)).not_to be_valid
		end

		it "is invalid without a sentiment" do 
			expect(FactoryGirl.build(:tag, sentiment: nil)).not_to be_valid
		end

		it "is invalid without a valid sentiment" do 
			expect(FactoryGirl.build(:tag, sentiment: "INVALID")).not_to be_valid
		end
	end

	describe "helpers" do 

		before(:each) do 
			@tag_name = "#justin"

			@tag = FactoryGirl.create(:tag, name: @tag_name)
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
	end

	describe "#intiate_sentiment" do

		before(:each) do 
			@tag_name = "#justin"

			@tag = FactoryGirl.create(:tag, name: @tag_name)

			@now = Time.parse("1969-07-20 20:17:40")
			allow(Time).to receive(:now).and_return(@now)

			allow_any_instance_of(Tweet).to receive(:determine_sentiment).and_return('positive')

			allow(@tag).to receive(:get_tweets_in_time_range).and_return(unprocessed_tweets(3, @tag_name, @now-1.weeks, @now))			
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

		it "sets the correct sentiment based on tweets" do 
			allow_any_instance_of(Tweet).to receive(:determine_sentiment).and_return("positive")

			expect(@tag.sentiment).to eq "positive"
		end

		it "creates an error if an invalid sentiment is returned" #do 
		# 	allow_any_instance_of(Tweet).to receive(:determine_sentiment).and_return("INVALID")
			
		# 	expect(@tag).to receive(:dispatch_error).with("A tweet returned a bad sentiment").at_least(:once)
		# end
	end

	describe "#get_tweets_in_time_range" do
		before(:each) do 
			@tag_name = "#justin"

			@tag = FactoryGirl.create(:tag, name: @tag_name)

			@now = Time.parse("1969-07-20 20:17:40")
			allow(Time).to receive(:now).and_return(@now)


			allow(@tag).to receive(:get_tweets_in_time_range).and_return(unprocessed_tweets(3, @tag_name, @now-1.weeks, @now))	

			@search = ""
			@since_time = @now
			@until_time = @now
		end

		it "should return tweets when successful" # do 
			# allow_any_instance_of(TwitterAPI::Client).to receive(:search).with(@search, @since_time, @until_time).and_return(unprocessed_tweets(3, @tag_name, @now-1.weeks, @now))

		# end
	end

	describe "#dispatch_error" do
		before(:each) do 
			@tag_name = "#justin"

			@tag = FactoryGirl.create(:tag, name: @tag_name)
		end		

		it "should print the error to console" do 
			error_text = "This is the error."

			expect(STDOUT).to receive(:puts).with(error_text)

			@tag.send(:dispatch_error, error_text)
		end
	end

end 