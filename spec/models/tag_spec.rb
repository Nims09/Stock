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

	context "validates" do 

		it "has a valid factory" do 
			expect(FactoryGirl.create(:tag)).to be_valid
		end 

	end

	context "intiate_sentiment" do

		it "has a helper for generated unprocessed tweets" do 
			tag_name = "#justin"
			start_date = '2015-09-12 2:31:32 +0'
			end_date = '2015-09-13 2:31:32 +0'
			# Example: "2015-09-21 23:59:11 +0000"

			tweets = unprocessed_tweets(3, tag_name, start_date, end_date)

			expect(tweets.size).to eq 3
			expect(tweets.first.favorite_count).to eq "3"
			expect(tweets.first.created_at).to eq start_date
			expect(tweets.last.created_at).to eq end_date
			expect(tweets.last.text).to eq tag_name
		end


		it "makes a call for tweets" do 
			tag_name = "#justin"
			start_date = '2015-09-12 2:31:32 +0'
			end_date = '2015-09-13 2:31:32 +0'

			test = FactoryGirl.create(:tag, name: tag_name)

			allow(test).to receive(:get_tweets_in_time_range).and_return(unprocessed_tweets(3, tag_name, start_date, end_date))

			test.intiate_sentiment
		end 

		it "saves a correct tweet"
	end

end 