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

class Tag < ActiveRecord::Base
	has_many :tweets

	validates :name, presence: :true

	# TODO : Needs tweet object, as this will generate initial batch
	# 	=> Need to think about how this is done intially
	# 	=> Perhaps come to some specified winow, or how do we know how many initial tweets we need, initial analysis 	
	def intiate_sentiment
		initial_tweets = get_tweets_in_time_range self.name, (Time.now-1.weeks), Time.now 

		initial_tweets.each do |tweet|
			new_tweet = self.tweets.new

			new_tweet.favorite_count = tweet.favorite_count 
			new_tweet.filter_level = tweet.filter_level 
			new_tweet.retweet_count = tweet.retweet_count 
			new_tweet.text = tweet.text 
			new_tweet.tweeted_at = tweet.created_at 

			if !new_tweet.save
				dispatch_error "Failed to save tweet" 
			end  
		end

		# commit_tweets_to_database tweets

		# creates a tweet to save in the DB, checks sentiment on them for intial sentiment

		# TODO : This should keep track of ranges searched, if somthing is in an already searched range, then just retrieve the tweets from the database
		# => -- This will take care to make sure we don't retrieve duplicate time ranges of tweets and just query the DB --		
		# => This is unessecary, we just need to SELECT FIRST matching a date range in the database

	end

	private

	# TODO : =>	This needs to be replaced by web scraping. 
	# 			The API simply does not cover the needs for 
	# 			an application like this with the strict 
	# 			limits. We will use the gem for now. 
	# 		 => This limit appears to be with the NUMBER of
	# 			requests you, not the actual amount of tweets
	# 			being returned in each
	def get_tweets_in_time_range(search, since_time, until_time)
		client = TwitterAPI.new.client

		begin
			return client.search(
				search,
				include_entities: true,
				result_type: "recent",
				since: since_time.to_date, 
				until: until_time.to_date
			)
		rescue Twitter::Error::Unauthorized
			dispatch_error "Unauthorized credentials"
			return []
		end
	end 

	# TODO : Add more functionality to pass errors forward
	def dispatch_error(error)
		puts error
	end
end
